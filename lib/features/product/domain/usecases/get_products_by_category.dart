import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:store24_technical_task/core/error/failures.dart';
import 'package:store24_technical_task/core/usecase/usecase.dart';
import 'package:store24_technical_task/features/product/domain/entities/product.dart';
import 'package:store24_technical_task/features/product/domain/repositories/product_repository.dart';

class CategoryParams extends Equatable {
  final String categorySlug;

  const CategoryParams(this.categorySlug);

  @override
  List<Object> get props => [categorySlug];
}

class GetProductsByCategory implements UseCase<List<Product>, CategoryParams> {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(CategoryParams params) async {
    return await repository.getProductsByCategory(params.categorySlug);
  }
}