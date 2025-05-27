import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store24_technical_task/features/product/domain/entities/product.dart';
import 'package:store24_technical_task/features/product/presentation/screens/widgets/product_card.dart';
import 'package:store24_technical_task/features/product/presentation/screens/widgets/product_detail_bottom_sheet.dart';

class ProductContent extends StatelessWidget {
  final List<Product> products;

  const ProductContent({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onAddToCart: () => _showProductDetails(context, product),
                );
              },
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProductDetailsBottomSheet(
        product: product,
        onAddToCart: () =>
            context.read<CartBloc>().add(AddToCartEvent(product)),
      ),
    );
  }
}
