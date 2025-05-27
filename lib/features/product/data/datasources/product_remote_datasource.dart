import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProductsByCategory(String categorySlug);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('https://dummyjson.com/products');
      if (response.statusCode == 200) {
        final data = response.data;
        return (data['products'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response =
          await dio.get('https://dummyjson.com/products/categories');
      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
 Future<List<ProductModel>> getProductsByCategory(String categorySlug) async {
  try {
    final url = 'https://dummyjson.com/products/category/$categorySlug';
    print('Fetching from: $url');
    final response = await dio.get(url);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return (response.data['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw ServerFailure();
    }
  } catch (e) {
    print('Error fetching products: $e');
    throw ServerFailure();
  }
}
}
