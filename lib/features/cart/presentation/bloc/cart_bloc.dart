import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/core/usecase/usecase.dart';
import 'package:store24_technical_task/features/cart/domain/entities/cart_item.dart';
import 'package:store24_technical_task/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store24_technical_task/features/cart/domain/usecases/clear_cart.dart';
import 'package:store24_technical_task/features/cart/domain/usecases/get_cart.dart';
import 'package:store24_technical_task/features/cart/domain/usecases/update_quantity.dart';

import '../../../product/domain/entities/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart addToCart;
  final GetCart getCart;
  final UpdateQuantity updateQuantity;
  final ClearCart clearCart;

  CartBloc({
    required this.addToCart,
    required this.getCart,
    required this.updateQuantity,
    required this.clearCart,
  }) : super(CartInitial()) {
    on<FetchCartEvent>((event, emit) async {
      emit(CartLoading());
      final result = await getCart(NoParams());
      result.fold(
        (failure) {
          print('FetchCartEvent failed: $failure');
          emit(CartError());
        },
        (items) {
          print('FetchCartEvent success, items: $items');
          emit(CartLoaded(items));
        },
      );
    });
    on<AddToCartEvent>((event, emit) async {
      final item = CartItem(product: event.product, quantity: 1);
      print('Adding to cart: $item');
      await addToCart(item);
      add(FetchCartEvent());
    });
    on<UpdateQuantityEvent>((event, emit) async {
      print(
          'Updating quantity for productId ${event.productId} to ${event.quantity}');
      await updateQuantity(
          UpdateQuantityParams(event.productId, event.quantity));
      add(FetchCartEvent());
    });
    on<ClearCartEvent>((event, emit) async {
      print('Clearing cart');
      await clearCart(NoParams());
      add(FetchCartEvent());
    });
    on<MakeOrderEvent>((event, emit) async {
      emit(CartLoading());
      print('Making order');
      // I'm just simulating...)
      await Future.delayed(const Duration(seconds: 2));
      await clearCart(NoParams());
      emit(CartOrderSuccess());
    });
  }
}
