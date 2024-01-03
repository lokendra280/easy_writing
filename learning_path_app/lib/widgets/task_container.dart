import 'package:flutter/material.dart';
import 'package:learning_path_app/pages/home_page.dart';
import 'package:learning_path_app/pages/subscription_page.dart';
import 'package:learning_path_app/pages/subscription_page_aca.dart';
import 'package:learning_path_app/pages/tips_detail_page.dart';
import 'package:learning_path_app/provider/task_model.dart';
import 'package:learning_path_app/widgets/custom_theme.dart';
import 'package:learning_path_app/widgets/size_utils.dart';
import 'package:provider/provider.dart';

class TaskContainer extends StatelessWidget {
  final String centerText;
  final double? height;
  final String jsonPath;
  final BuildContext context;
  final String path;
  final bool hasShadow;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final double? elevation;

  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  final bool? isSubscribed;
  final String category;

  const TaskContainer({
    super.key,
    required this.centerText,
    this.margin,
    this.elevation,
    this.height = 100,
    this.backgroundColor,
    required this.jsonPath,
    this.contentPadding,
    required this.context,
    required this.category,
    this.path = "Tips",
    this.isSubscribed,
    this.hasShadow = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<TaskModel>(context, listen: false).selectTask(centerText);

        if (centerText.contains("Tips") && !isSubscribed!) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Subscribe"),
              content: const Text(
                "Subscribe to gain access to comprehensive model answers and valuable tips",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (category == "Academic") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SubscriptionPageAcademic(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SubscriptionPage(),
                        ),
                      );
                    }
                  },
                  child: const Text("Subscribe"),
                ),
                TextButton(
                  child: const Text("Close"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => centerText.contains("Tips")
                  ? TipsDetailPage(
                      jsonPath: jsonPath,
                      category: category,
                    )
                  : HomePage(
                      jsonPath: jsonPath,
                      path: path,
                      category: category,
                    ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.wp),
          boxShadow: [
            if (hasShadow)
              const BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 2,
                color: CustomTheme.lightGray,
              ),
          ],
        ),
        margin: margin ??
            EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp,
                vertical: 10.hp),
        child: Material(
          elevation: elevation ?? 0.1,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.wp),
          child: Container(
            padding: contentPadding ?? EdgeInsets.all(10.wp),
            decoration: BoxDecoration(
              color:
                  backgroundColor ?? CustomTheme.primaryColor.withOpacity(0.04),
              borderRadius: BorderRadius.circular(borderRadius ?? 10.wp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    centerText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                centerText == "Tips"
                    ? const Icon(
                        Icons.arrow_right_rounded,
                        color: CustomTheme.primaryColor,
                        size: 25,
                      )
                    : const Icon(
                        Icons.arrow_right,
                        color: CustomTheme.primaryColor,
                        size: 25,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
