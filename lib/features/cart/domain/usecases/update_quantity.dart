import 'package:dartz/dartz.dart';
import 'package:store24_technical_task/core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class UpdateQuantity implements UseCase<void, UpdateQuantityParams> {
  final CartRepository repository;

  UpdateQuantity(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateQuantityParams params) async {
    return await repository.updateQuantity(params.productId, params.quantity);
  }
}

class UpdateQuantityParams {
  final int productId;
  final int quantity;

  UpdateQuantityParams(this.productId, this.quantity);
}