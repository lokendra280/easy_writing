import 'package:flutter/material.dart';
import 'package:learning_path_app/widgets/custom_theme.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final double borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double iconSize;
  final bool shadow;
  final bool hasBorderOutline;
  const CustomIconButton(
      {Key? key,
      required this.icon,
      this.onPressed,
      this.borderRadius = 45,
      this.backgroundColor = CustomTheme.lighterGrey,
      this.iconColor = CustomTheme.black,
      this.horizontalPadding = 8,
      this.verticalPadding = 8,
      this.iconSize = 20,
      this.shadow = true,
      this.hasBorderOutline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.all(6),
        child: Material(
          color: backgroundColor,
          elevation: 0,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: hasBorderOutline
                  ? (horizontalPadding - 5)
                  : horizontalPadding,
              vertical:
                  hasBorderOutline ? (verticalPadding - 5) : verticalPadding,
            ),
            decoration: BoxDecoration(
              border: hasBorderOutline
                  ? Border.all(width: 2, color: iconColor)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
