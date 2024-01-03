import 'package:flutter/material.dart';

class TextWithDividers extends StatelessWidget {
  final String text;
  final double dividerThickness;
  final bool moreContext;

  const TextWithDividers({
    Key? key,
    this.moreContext = false,
    required this.text,
    this.dividerThickness = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: dividerThickness),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: moreContext ? 17 : 14,
            color: moreContext
                ? const Color(
                    0xFF4CAF50,
                  )
                : Colors.black,
          ),
        ),
      ],
    );
  }
}
