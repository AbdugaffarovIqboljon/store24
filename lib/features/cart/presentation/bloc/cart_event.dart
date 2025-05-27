part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;

  const AddToCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateQuantityEvent extends CartEvent {
  final int productId;
  final int quantity;

  const UpdateQuantityEvent(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

class ClearCartEvent extends CartEvent {}

class MakeOrderEvent extends CartEvent {}