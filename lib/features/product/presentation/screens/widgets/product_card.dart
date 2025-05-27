import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store24_technical_task/features/product/domain/entities/product.dart';
import 'dart:ui' as ui;

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    const innerGradient = LinearGradient(
      colors: [Color(0x00FFFFFF), Color(0x00FFFFFF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return GestureDetector(
      onTap: onAddToCart,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              gradient: innerGradient,
              border: Border.all(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: product.thumbnail != null
                      ? CachedNetworkImage(
                          imageUrl: product.thumbnail!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.broken_image_rounded, size: 50),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF000000).withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: Text(
                      "+ ${product.price.toStringAsFixed(0)} монет",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
