import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/product/presentation/bloc/product_bloc.dart';
import '../../domain/entities/product.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фреши'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_drink),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return const Center(child: Text('Error loading products'));
          } else if (state is ProductLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductCard(
                  product: product,
                  onTap: () => _showProductDetails(context, product),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ProductDetailsBottomSheet(
        product: product,
        onAddToCart: () {},
        // onAddToCart: () => context.read<CartBloc>().add(AddToCartEvent(product)),
      ),
    );
  }
}




class ProductCard extends StatelessWidget {
 final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define gradient outside build for performance
    const borderGradient = LinearGradient(
      colors: [
        Color(0x00FFFFFF), // #FFFFFF with 0% opacity
        Color(0x00EFEFEF), // #EFEFEF with 0% opacity
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    const innerGradient = LinearGradient(
      colors: [
        Color(0x80FFFFFF), // #FFFFFF with 50% opacity
        Color(0x00FFFFFF), // #FFFFFF with 0% opacity
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40), // Background blur
          child: Container(
            decoration: BoxDecoration(
              gradient: innerGradient, // Inner gradient
              border: Border.all(
                width: 1,
                color: Colors.transparent, // Required for gradient border
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: Colors.transparent,
                ),
                gradient: borderGradient, // Border gradient
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.title,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "+ ${product.price.toStringAsFixed(0)} монет",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: Colors.blue),
                          onPressed: onTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            product.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(product.description),
          const SizedBox(height: 16),
          Text('Price: ${product.price.toStringAsFixed(0)} монет'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              onAddToCart();
              Navigator.pop(context);
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
