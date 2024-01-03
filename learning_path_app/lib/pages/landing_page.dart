import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learning_path_app/provider/homepage_provider.dart';
import 'package:learning_path_app/widgets/custom_app_bar.dart';
import 'package:learning_path_app/widgets/custom_theme.dart';
import 'package:learning_path_app/widgets/task_container.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isSubscribed = false;
  late PageController _pageController;

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomepageProvider>(context);
    provider.checkAndUpdateSubscriptionStatus();
    isSubscribed = provider.isSubscribed;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Master Easy",
        backgroundColor: CustomTheme.primaryColor,
        showBackButton: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.rate_review,
                ),
              ],
            ),
            label: 'General',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.book,
                ),
              ],
            ),
            label: 'Academy',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.share_rounded,
                ),
              ],
            ),
            label: 'Share',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 2),
              curve: Curves.easeInOut,
            );
          });

          // String appLink;

          // if (Platform.isIOS) {
          //   appLink = 'https://apps.apple.com/app/id[YOUR_APP_ID]';
          // } else if (Platform.isAndroid) {
          //   appLink =
          //       'https://play.google.com/store/apps/details?id=[YOUR_PACKAGE_NAME]';
          // } else {
          //   appLink = 'https://yourwebsite.com';
          // }

          // Share.share(
          //     'Maximize your success in the Writing Test or achieve the highest score with "IELTS Writing Model Anaswers" App : $appLink');
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          _GeneralWidget(isSubscribed: isSubscribed),
          _AcademicWidget(isSubscribed: isSubscribed),
        ],
      ),
    );
  }
}

class _AcademicWidget extends StatelessWidget {
  const _AcademicWidget({
    super.key,
    required this.isSubscribed,
  });

  final bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        TaskContainer(
          centerText:
              "Task 1) Total (40) Model Answers covering bar/line/pie charts, tables, processes, and maps",
          height: 70,
          jsonPath: "assets/Academic/AcadAWriting.json",
          context: context,
          path: "AcadA",
          category: "Academic",
        ),
        TaskContainer(
          centerText: "Task 2) Essay Writing (60) Model Answers",
          height: 70,
          jsonPath: "assets/Academic/AcadBWriting.json",
          context: context,
          path: "AcadB",
          category: "Academic",
        ),
        TaskContainer(
          centerText:
              "Tips for succeeding in IELTS Academic Writing or achieving a high score",
          height: 70,
          jsonPath: "assets/Academic/AcadCWritingTips.json",
          context: context,
          isSubscribed: isSubscribed,
          category: "Academic",
        ),
      ],
    );
  }
}

class _GeneralWidget extends StatelessWidget {
  const _GeneralWidget({
    super.key,
    required this.isSubscribed,
  });

  final bool isSubscribed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        TaskContainer(
          centerText: "Task 1) Formal Letters (60) Model Answers",
          height: 70,
          jsonPath: "assets/model_answers_json/AWriting.json",
          context: context,
          path: "A",
          category: "General",
        ),
        TaskContainer(
          centerText: "Task 1) Semi-Formal Letters (60) Model Answers",
          height: 70,
          jsonPath: "assets/model_answers_json/BWriting.json",
          context: context,
          path: "B",
          category: "General",
        ),
        TaskContainer(
          centerText: "Task 1) Informal Letters (60) Model Answers",
          height: 70,
          jsonPath: "assets/model_answers_json/CWriting.json",
          context: context,
          path: "C",
          category: "General",
        ),
        TaskContainer(
          centerText: "Task 2) Essay Writing (60) Model Answers",
          height: 70,
          jsonPath: "assets/model_answers_json/DWriting.json",
          context: context,
          path: "D",
          category: "General",
        ),
        TaskContainer(
          centerText:
              "Tips for succeeding in IELTS General Writing or achieving a high score",
          height: 70,
          jsonPath: "assets/model_answers_json/EWritingTips.json",
          context: context,
          isSubscribed: isSubscribed,
          category: "General",
        ),
      ],
    );
  }
}
