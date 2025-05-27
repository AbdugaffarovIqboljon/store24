part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsEvent extends ProductEvent {}

class FetchCategoriesEvent extends ProductEvent {}

class FetchProductsByCategoryEvent extends ProductEvent {
  final String categorySlug;

  const FetchProductsByCategoryEvent(this.categorySlug);

  @override
  List<Object> get props => [categorySlug];
}