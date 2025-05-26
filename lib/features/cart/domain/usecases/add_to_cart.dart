import 'package:dartz/dartz.dart';
import 'package:store24_technical_task/core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCart implements UseCase<void, CartItem> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failure, void>> call(CartItem params) async {
    return await repository.addToCart(params);
  }
}