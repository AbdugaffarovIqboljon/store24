import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/cart/domain/entities/cart_item.dart';
import 'package:store24_technical_task/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store24_technical_task/features/cart/presentation/screens/widgets/cart_item_widget.dart';
import 'package:store24_technical_task/features/cart/presentation/screens/widgets/order_summary_widget.dart';

class CartContentWidget extends StatelessWidget {
  final List<CartItem> items;

  const CartContentWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    final totalItems = items.fold(0, (sum, item) => sum + item.quantity);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Cart Items Section
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F242F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isLast = index == items.length - 1;

                      return Column(
                        children: [
                          CartItemWidget(
                            item: item,
                            onQuantityChanged: (quantity) =>
                                context.read<CartBloc>().add(
                                      UpdateQuantityEvent(
                                        item.product.id,
                                        quantity,
                                      ),
                                    ),
                          ),
                          if (!isLast)
                            const Divider(
                              color: Color(0xFF2A3038),
                              height: 1,
                              thickness: 1,
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                // Order Summary Section
                OrderSummaryWidget(
                  totalItems: totalItems,
                  totalPrice: totalPrice,
                ),
              ],
            ),
          ),
        ),
        // Order Button
        if (items.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.read<CartBloc>().add(MakeOrderEvent()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0ABAB5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Оформить закас',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
