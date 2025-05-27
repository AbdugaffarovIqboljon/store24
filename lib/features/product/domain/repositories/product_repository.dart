import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../entities/category.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Category>>> getCategories(); 
  Future<Either<Failure, List<Product>>> getProductsByCategory(String categorySlug);
}