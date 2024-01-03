import 'package:flutter/material.dart';
import 'package:learning_path_app/widgets/custom_theme.dart';
import 'package:learning_path_app/widgets/size_utils.dart';

class CustomOutlineButton extends StatelessWidget {
  final Function()? onPressed;
  final double verticalPadding;
  final double horizontaPadding;
  final String name;
  final Color textColor;
  final Color outLineColor;
  final Color backGroundColor;
  final Widget? prefixIcon;
  final double fontSize;

  const CustomOutlineButton(
      {Key? key,
      this.onPressed,
      this.verticalPadding = 10,
      this.horizontaPadding = 15,
      required this.name,
      this.textColor = CustomTheme.primaryColor,
      this.outLineColor = CustomTheme.primaryColor,
      this.backGroundColor = Colors.white,
      this.prefixIcon,
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(8),
      color: CustomTheme.primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding.hp,
              horizontal: horizontaPadding.hp,
            ),
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 1.wp, color: outLineColor)),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null)
                    Padding(
                      padding: EdgeInsets.only(right: 8.wp),
                      child: prefixIcon!,
                    ),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall!.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
