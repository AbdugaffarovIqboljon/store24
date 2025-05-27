import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getProducts();
      return Right(remoteProducts.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final remoteCategories = await remoteDataSource.getCategories();
      return Right(remoteCategories);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String categorySlug) async {
    try {
      final remoteProducts =
          await remoteDataSource.getProductsByCategory(categorySlug);
      return Right(remoteProducts.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}