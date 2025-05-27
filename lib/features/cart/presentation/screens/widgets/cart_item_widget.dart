import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store24_technical_task/features/cart/domain/entities/cart_item.dart';
import 'package:store24_technical_task/features/cart/presentation/screens/widgets/quantity_button.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF2A3038),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: item.product.thumbnail != null
                  ? CachedNetworkImage(
                      imageUrl: item.product.thumbnail!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.broken_image_rounded,
                        color: Color(0xFF94969C),
                        size: 30,
                      ),
                    )
                  : const Icon(
                      Icons.broken_image_rounded,
                      color: Color(0xFF94969C),
                      size: 30,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  style: const TextStyle(
                    color: Color(0xFFF5F5F6),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.product.price.toStringAsFixed(0)} монет x ${item.quantity}',
                  style: const TextStyle(
                    color: Color(0xFF94969C),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Quantity Controls
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A3038),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                QuantityButton(
                  icon: Icons.remove,
                  onPressed: item.quantity > 1
                      ? () => onQuantityChanged(item.quantity - 1)
                      : null,
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: 40),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${item.quantity}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFF5F5F6),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                QuantityButton(
                  icon: Icons.add,
                  onPressed: () => onQuantityChanged(item.quantity + 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
