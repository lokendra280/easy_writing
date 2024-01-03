import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_path_app/constants.dart';
import 'package:learning_path_app/models/question_model.dart';
import 'package:learning_path_app/pages/subscription_page.dart';
import 'package:learning_path_app/pages/subscription_page_aca.dart';
import 'package:learning_path_app/pages/task_detail_page.dart';
import 'package:learning_path_app/provider/homepage_provider.dart';
import 'package:learning_path_app/provider/task_model.dart';
import 'package:learning_path_app/utils/regex_selected_text.dart';
import 'package:learning_path_app/widgets/custom_app_bar.dart';
import 'package:learning_path_app/widgets/custom_outline_button.dart';
import 'package:learning_path_app/widgets/custom_theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String jsonPath;
  final String path;
  final String category;
  const HomePage({
    super.key,
    required this.path,
    required this.jsonPath,
    required this.category,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<QuestionModel> questions = [];
  bool isSubscribed = false;
  bool isSearching = false;
  String searchQuery = "";
  String selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Provider.of<HomepageProvider>(context, listen: false)
        .loadQuestions(widget.path, widget.category);
  }

  Future<void> loadQuestions() async {
    final String response = await rootBundle.loadString(widget.jsonPath);
    final List<dynamic> data = json.decode(response);
    setState(() {
      questions = data.map((json) => QuestionModel.fromJson(json)).toList();
    });
  }

  void showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Subscribe."),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Get full access to the model answers in the '${widget.category} Writing' section along with tips to achieve high score.",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.category == "Academic"
                      ? const SubscriptionPageAcademic()
                      : const SubscriptionPage(),
                ),
              );
            },
            child: const Text(
              "Subscribe",
              style: TextStyle(
                  // color: Color(0xFF6301ef),
                  ),
            ),
          ),
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomepageProvider>(context);
    isSubscribed = provider.isSubscribed;
    List<QuestionModel> displayedQuestions = getDisplayedQuestions(provider);

    String selectedText = Provider.of<TaskModel>(context).selectedTaskText;

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: CustomTheme.primaryColor,
        title: getFormattedTitle(selectedText, category: widget.category),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Questions'),
            Tab(text: 'Bookmarks'),
            Tab(text: 'Read'),
          ],
          onTap: (index) {
            setState(() {});
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // isSearching
          //     ? Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //         child: _buildSearchField(),
          //       )
          //     : Container(),
          Expanded(
            child: ListView.builder(
              itemCount: displayedQuestions.length,
              itemBuilder: (context, index) {
                QuestionModel question = displayedQuestions[index];
                return _buildQuestionItem(question, index);
              },
            ),
          ),
          if (!isSubscribed)
            SizedBox(
              width: 300,
              child: CustomOutlineButton(
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: CustomTheme.primarymaterialcolor,
                  //   foregroundColor: Colors.white,
                  //   minimumSize: const Size(40, 50),
                  // ),
                  onPressed: () {
                    if (widget.category == "Academic") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SubscriptionPageAcademic(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubscriptionPage(),
                        ),
                      );
                    }
                  },
                  name:
                      'Subscribe for exclusive access to \n well-written  model \n answers and helpful tips'

                  // child: const Text(
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 14,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  ),
            ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  List<QuestionModel> getDisplayedQuestions(HomepageProvider provider) {
    switch (_tabController.index) {
      case 1: // Bookmarks
        return provider.getBookmarks(widget.path);
      case 2: // Marked as Read
        return provider.getMarkedAsRead(widget.path);
      default: // All Questions
        return provider.getQuestions(widget.path);
    }
  }

  Widget _buildQuestionItem(QuestionModel question, int index) {
    return GestureDetector(
      onTap: () {
        if (index < 5 || isSubscribed) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskDetailPage(
                taskDetail: question,
                path: widget.path,
                category: widget.category,
                academic: widget.category == "Academic" ? true : false,
              ),
            ),
          );
        } else {
          showSubscriptionDialog(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Row(
          children: [
            // Container(
            //   padding: const EdgeInsets.all(5),
            //   decoration: BoxDecoration(
            //     color: const Color(0xFF5448C0),
            //     shape: BoxShape.circle,
            //     border: Border.all(style: BorderStyle.solid),
            //   ),
            //   child: Text(
            //     "${question.srNo}",
            //     style: const TextStyle(color: Colors.white),
            //   ),
            // ),
            // const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '${question.srNo}: ${question.question}',
                  style: GoogleFonts.openSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            // buildPriorityIcon(question.quesType),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search Questions',
          labelStyle: TextStyle(color: baseColor),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: baseColor)),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                isSearching = false;
                searchQuery = "";
              });
            },
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }
}
