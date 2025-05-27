import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/category.dart';
import '../repositories/product_repository.dart';

class GetCategories implements UseCase<List<Category>, NoParams> {
  final ProductRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}