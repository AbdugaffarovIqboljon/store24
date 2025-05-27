import 'package:hive/hive.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final int stock;

  @HiveField(6)
  final String? thumbnail;

  @HiveField(7)
  final String? availabilityStatus;

  @HiveField(8)
  final String? brand;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.stock,
    this.thumbnail,
    this.availabilityStatus,
    this.brand,
  });

  // Convert to Product entity if needed
  Product toEntity() => Product(
        id: id,
        title: title,
        description: description,
        price: price,
        rating: rating,
        stock: stock,
        thumbnail: thumbnail,
        availabilityStatus: availabilityStatus,
        brand: brand,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      stock: json['stock'],
      thumbnail: json['thumbnail'],
      availabilityStatus: json['availabilityStatus'],
      brand: json['brand'],
    );
  }
}