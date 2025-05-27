import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store24_technical_task/features/cart/presentation/screens/widgets/cart_content_widget.dart';
import 'package:store24_technical_task/features/cart/presentation/screens/widgets/empty_cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ValueNotifier<bool> _refresh = ValueNotifier<bool>(false);

  static const LinearGradient _orangeGradient = LinearGradient(
    colors: [Color(0xFFFFEF01), Color(0xFFFFC900)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void initState() {
    super.initState();
    _refresh.value = !_refresh.value;
  }

  void clearCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Очистить корзину'),
        content: const Text(
          'Вы уверены, что хотите очистить корзину?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(ClearCartEvent());
              Navigator.pop(context);
            },
            child: const Text('Да'),
          ),
        ],
      ),
    );
  }

  void successfullyPlacedOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Успешно'),
        content: const Text(
          'Ваш заказ успешно создан. Спасибо за покупку.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _refresh.value = true;
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _refresh.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_refresh.value) {
        context.read<CartBloc>().add(FetchCartEvent());
        _refresh.value = false;
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFF2D2),
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 150),
        child: Container(
          height: 150,
          decoration: const BoxDecoration(
            gradient: _orangeGradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Row(
              children: [
                const Text(
                  'Корзина',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded && state.items.isNotEmpty) {
                      return IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: clearCartDialog,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0ABAB5)),
            );
          } else if (state is CartError) {
            return const Center(child: Text('Error loading cart'));
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return const EmptyCartWidget();
            }

            return CartContentWidget(items: state.items);
          } else if (state is CartOrderSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              successfullyPlacedOrderDialog();
            });
            return const Center(
              child: Text(
                'Ваш заказ успешно создан!',
                style: TextStyle(
                  color: Color(0xFFCECFD2),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
