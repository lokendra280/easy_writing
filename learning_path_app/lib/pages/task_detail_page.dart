import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_path_app/models/question_model.dart';
import 'package:learning_path_app/provider/homepage_provider.dart';
import 'package:learning_path_app/provider/task_model.dart';
import 'package:learning_path_app/utils/regex_selected_text.dart';
import 'package:learning_path_app/widgets/custom_app_bar.dart';
import 'package:learning_path_app/widgets/custom_theme.dart';
import 'package:learning_path_app/widgets/pop_out_image.dart';
import 'package:provider/provider.dart';

class TaskDetailPage extends StatefulWidget {
  final QuestionModel taskDetail;
  final String path;
  final String? category;
  final bool? academic;
  const TaskDetailPage({
    super.key,
    required this.taskDetail,
    required this.path,
    this.academic,
    this.category,
  });

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  String getFormattedQuestion(String question) {
    RegExp pattern = RegExp(r'^\(Task-1\)|^\(Question-1\)');
    return question.replaceFirst(pattern, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    String selectedText = Provider.of<TaskModel>(context).selectedTaskText;

    var provider = Provider.of<HomepageProvider>(context, listen: false);
    bool isSaved =
        provider.getBookmarks(widget.path).contains(widget.taskDetail);
    bool isRead =
        provider.getMarkedAsRead(widget.path).contains(widget.taskDetail);

    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: CustomTheme.primaryColor,
        // elevation: 0,
        // centerTitle: false,
        // titleSpacing: 0.0,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        // title: Transform(
        //   transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
        //   child: Text(
        //     getFormattedTitle(selectedText, category: widget.category),
        //     style: const TextStyle(
        //       color: Colors.black,
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        title: getFormattedTitle(selectedText, category: widget.category),
        actions: [
          IconButton(
            iconSize: 25,
            onPressed: () {
              provider.toggleBookmark(widget.path, widget.taskDetail);
              setState(() {});
            },
            icon: Icon(
              isSaved ? Icons.bookmark_add_rounded : Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
          IconButton(
            iconSize: 25,
            onPressed: () {
              provider.toggleMarkAsRead(widget.path, widget.taskDetail);
              setState(() {});
            },
            icon: Icon(
              isRead ? Icons.save : Icons.save_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      getFormattedQuestion(widget.taskDetail.question),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                  ],
                ),
              ),
              if (widget.academic == true &&
                  getFormattedTitle(selectedText) == "Task 1")
                PopOutImage(
                  imagePath: 'assets/Academic/${widget.taskDetail.srNo}.png',
                ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getFormattedTitle(selectedText) == "Tips"
                        ? Container()
                        : Column(
                            children: [
                              Text(
                                "Model Answer:",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8EAF6),
                      ),
                      child: SelectableText(
                        widget.taskDetail.answer,
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
