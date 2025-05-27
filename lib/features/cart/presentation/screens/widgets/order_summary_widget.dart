import 'package:flutter/material.dart';
import 'package:store24_technical_task/features/cart/presentation/screens/widgets/summary_row.dart';

class OrderSummaryWidget extends StatelessWidget {
  final int totalItems;
  final double totalPrice;

  const OrderSummaryWidget({
    super.key,
    required this.totalItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F242F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SummaryRow(
            label: 'Товары, $totalItems шт.',
            value: '${totalPrice.toStringAsFixed(0)} монет',
            isSubtotal: true,
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: const Color(0xFF2A3038),
          ),
          const SizedBox(height: 16),
          SummaryRow(
            label: 'Итого к оплате',
            value: '${totalPrice.toStringAsFixed(0)} монет',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
