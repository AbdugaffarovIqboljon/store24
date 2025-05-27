import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/product/domain/entities/category.dart';
import 'package:store24_technical_task/features/product/domain/entities/product.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products_by_category.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final GetCategories getCategories;
  final GetProductsByCategory getProductsByCategory;

  ProductBloc(this.getProducts, this.getCategories, this.getProductsByCategory)
      : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await getProducts(NoParams());
      result.fold(
        (failure) => emit(ProductError()),
        (products) => emit(ProductLoaded(products)),
      );
    });

    on<FetchCategoriesEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await getCategories(NoParams());
      result.fold(
        (failure) => emit(ProductError()),
        (categories) => emit(CategoriesLoaded(categories)),
      );
    });

    on<FetchProductsByCategoryEvent>((event, emit) async {
      emit(ProductLoading());
      final result =
          await getProductsByCategory(CategoryParams(event.categorySlug));
      result.fold(
        (failure) => emit(ProductError()),
        (products) => emit(ProductLoaded(products)),
      );
    });
  }
}
