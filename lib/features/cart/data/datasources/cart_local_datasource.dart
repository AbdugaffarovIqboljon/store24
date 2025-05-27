import 'package:hive/hive.dart';
import '../../../../core/error/failures.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(CartItemModel item);
  Future<List<CartItemModel>> getCart();
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartItemModel> box;

  CartLocalDataSourceImpl(this.box);

  @override
  Future<void> addToCart(CartItemModel item) async {
    try {
      final existingItemIndex = box.values
          .toList()
          .indexWhere((i) => i.productModel.id == item.productModel.id);
      if (existingItemIndex != -1) {
        final existingItem = box.getAt(existingItemIndex)!;
        await box.putAt(
          existingItemIndex,
          CartItemModel(
            productModel: existingItem.productModel,
            quantity: existingItem.quantity + item.quantity,
          ),
        );
        print('Updated item in box: ${box.getAt(existingItemIndex)}');
      } else {
        await box.add(item);
        print('Added new item to box: $item, Box length: ${box.length}');
      }
    } catch (e) {
      print('Error adding to cart: $e');
      throw CacheFailure();
    }
  }

  @override
  Future<List<CartItemModel>> getCart() async {
    try {
      final items = box.values.toList();
      print('Retrieved cart items: $items');
      return items;
    } catch (e) {
      print('Error getting cart: $e');
      throw CacheFailure();
    }
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      final index = box.values
          .toList()
          .indexWhere((item) => item.productModel.id == productId);
      if (index != -1) {
        if (quantity <= 0) {
          await box.deleteAt(index);
        } else {
          final item = box.getAt(index)!;
          await box.putAt(
            index,
            CartItemModel(productModel: item.productModel, quantity: quantity),
          );
        }
        print('Updated quantity for productId $productId: ${box.getAt(index)}');
      }
    } catch (e) {
      print('Error updating quantity: $e');
      throw CacheFailure();
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await box.clear();
      print('Cart cleared, Box length: ${box.length}');
    } catch (e) {
      print('Error clearing cart: $e');
      throw CacheFailure();
    }
  }
}