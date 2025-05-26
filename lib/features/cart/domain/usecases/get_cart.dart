import 'package:dartz/dartz.dart';
import 'package:store24_technical_task/core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetCart implements UseCase<List<CartItem>, NoParams> {
  final CartRepository repository;

  GetCart(this.repository);

  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams params) async {
    return await repository.getCart();
  }
}