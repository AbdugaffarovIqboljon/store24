import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String? thumbnail;
  final double rating;
  final int stock;
  final String? brand;
  final String? availabilityStatus;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.availabilityStatus,
  });

  @override
  List<Object> get props => [id, title, description, price, rating, stock];
}