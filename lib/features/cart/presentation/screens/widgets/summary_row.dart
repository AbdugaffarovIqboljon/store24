import 'package:flutter/material.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isSubtotal;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isSubtotal = false,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? const Color(0xFFF5F5F6) : const Color(0xFF94969C),
            fontSize: isTotal ? 17 : 16,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFFF5F5F6),
            fontSize: isTotal ? 17 : 16,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}