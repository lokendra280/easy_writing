import 'package:flutter/material.dart';
import 'package:learning_path_app/models/question_model.dart';
import 'package:learning_path_app/utils/question_loader.dart';
import 'package:learning_path_app/utils/task_detail_answer_regex.dart';

class TipsDetailPage extends StatefulWidget {
  final String category;
  final String jsonPath;
  const TipsDetailPage({
    super.key,
    required this.jsonPath,
    required this.category,
  });

  @override
  State<TipsDetailPage> createState() => _TipsDetailPageState();
}

class _TipsDetailPageState extends State<TipsDetailPage> {
  late QuestionModel taskDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuestion();
  }

  Future<void> loadQuestion() async {
    var questions = await QuestionLoader.loadQuestions(widget.jsonPath);
    if (questions.isNotEmpty) {
      setState(() {
        taskDetail = questions.first;
        isLoading = false;
      });
    }
  }

  String getFormattedQuestion(String question) {
    RegExp pattern = RegExp(r'^\(Task-1\)|^\(Question-1\)');
    return question.replaceFirst(pattern, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Transform(
          transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: Text(
            "${widget.category} Writing Tips",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                      getFormattedQuestion(taskDetail.question),
                      style: const TextStyle(
                        fontSize: 20,
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFE8EAF6),
                ),
                child: RichText(
                  text: getStyledAnswer(taskDetail.answer),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
