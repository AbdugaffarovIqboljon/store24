import 'package:dartz/dartz.dart';
import 'package:store24_technical_task/core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class ClearCart implements UseCase<void, NoParams> {
  final CartRepository repository;

  ClearCart(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.clearCart();
  }
}