import 'package:hive/hive.dart';
import '../../../product/data/models/product_model.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends CartItem {
  @HiveField(0)
  final ProductModel productModel;

  @override
  @HiveField(1)
  final int quantity;

   CartItemModel({
    required this.productModel,
    required this.quantity,
  }) : super(product: productModel.toEntity(), quantity: quantity);

  factory CartItemModel.fromEntity(CartItem item) {
    if (item is CartItemModel) {
      return item;
    }
    return CartItemModel(
      productModel: item.product is ProductModel
          ? item.product as ProductModel
          : ProductModel(
              id: item.product.id,
              title: item.product.title,
              description: item.product.description,
              price: item.product.price,
              rating: item.product.rating,
              stock: item.product.stock,
              thumbnail: item.product.thumbnail,
              availabilityStatus: item.product.availabilityStatus,
              brand: item.product.brand,
            ),
      quantity: item.quantity,
    );
  }

  CartItemModel copyWith({
    ProductModel? productModel,
    int? quantity,
  }) {
    return CartItemModel(
      productModel: productModel ?? this.productModel,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItemModel &&
        other.productModel == productModel &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => Object.hash(productModel, quantity);

  @override
  String toString() {
    return 'CartItemModel(productModel: $productModel, quantity: $quantity)';
  }
}