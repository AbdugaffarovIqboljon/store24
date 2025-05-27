import 'package:flutter/material.dart';

class CategoryTabWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  static const Color selectedTextColor = Color(0xFF000000);
  static const Color unselectedTextColor = Color(0xFF6B7280);
  static const double fontSize = 14.0;
  static const FontWeight fontWeight = FontWeight.w400;

  const CategoryTabWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.white12.withValues(alpha: 0.085),
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutCubic,
            style: TextStyle(
              color: isSelected ? selectedTextColor : unselectedTextColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}