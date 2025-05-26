import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getProducts();
      // Mock drink data
      final drinkNames = [
        'Laimon Fresh 0.33л',
        'Laimon Fresh 0.33л',
        'Latte 600 г',
        'Latte 600 г',
      ];
      final drinkPrices = [16000.0, 24000.0, 20000.0, 16000.0];
      final products = remoteProducts.asMap().entries.map((entry) {
        final index = entry.key;
        final product = entry.value;
        return Product(
          id: product.id,
          title: drinkNames[index % drinkNames.length],
          description: product.description,
          price: drinkPrices[index % drinkPrices.length],
          thumbnail: product.thumbnail,
        );
      }).toList();
      return Right(products);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}