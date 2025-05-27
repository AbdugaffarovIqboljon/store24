import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store24_technical_task/features/product/domain/entities/product.dart';

class ProductDetailsBottomSheet extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductDetailsBottomSheet({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final maxHeight = h * 0.85;
    final minHeight = h * 0.75;

    return BottomSheet(
      showDragHandle: false,
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: maxHeight, minHeight: minHeight),
      onClosing: () => Navigator.pop(context),
      backgroundColor: const Color(0xFFFFFFFF),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: product.thumbnail != null
                      ? CachedNetworkImage(
                          height: 350,
                          width: 350,
                          imageUrl: product.thumbnail!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.broken_image_rounded, size: 50),
                ),
                const SizedBox(height: 12),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Brand: ${product.brand}',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Rating: ${product.rating.toStringAsFixed(1)}',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Stock: ${product.stock} items',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  'Availability: ${product.availabilityStatus}',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                Text(
                  'Цена: ${product.price.toStringAsFixed(0)} монет',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      onAddToCart();
                      Navigator.pop(context);
                    },
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
                      'Добавить в корзину',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
