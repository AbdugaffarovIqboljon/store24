import 'package:hive/hive.dart';
import '../../../product/data/models/product_model.dart';
import '../../domain/entities/cart_item.dart';

// part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends CartItem {
  @HiveField(0)
  final ProductModel productModel;

  @HiveField(1)
  final int quantity;

  CartItemModel({required this.productModel, required this.quantity})
      : super(product: productModel, quantity: quantity);

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      productModel: ProductModel(
        id: item.product.id,
        title: item.product.title,
        description: item.product.description,
        price: item.product.price,
        thumbnail: item.product.thumbnail,
      ),
      quantity: item.quantity,
    );
  }
}