import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/product/domain/entities/product.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_products.dart';


part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;

  ProductBloc(this.getProducts) : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await getProducts(NoParams());
      result.fold(
        (failure) => emit(ProductError()),
        (products) => emit(ProductLoaded(products)),
      );
    });
  }
}
