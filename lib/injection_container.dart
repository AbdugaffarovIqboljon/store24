import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'features/cart/data/datasources/cart_local_datasource.dart';
import 'features/cart/data/models/cart_item_model.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/add_to_cart.dart';
import 'features/cart/domain/usecases/clear_cart.dart';
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/cart/domain/usecases/update_quantity.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/product/data/datasources/product_remote_datasource.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/get_categories.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'features/product/domain/usecases/get_products_by_category.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Hive setup is now handled in main.dart

  // External
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton<Box<CartItemModel>>(() => Hive.box<CartItemModel>('cartBox'));

  // Product Feature
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => GetProducts(getIt()));
  getIt.registerLazySingleton(() => GetCategories(getIt()));
  getIt.registerLazySingleton(() => GetProductsByCategory(getIt()));
  getIt.registerLazySingleton(
    () => ProductBloc(getIt(), getIt(), getIt())..add(FetchProductsEvent()),
  );

  // Cart Feature
  getIt.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => AddToCart(getIt()));
  getIt.registerLazySingleton(() => GetCart(getIt()));
  getIt.registerLazySingleton(() => UpdateQuantity(getIt()));
  getIt.registerLazySingleton(() => ClearCart(getIt()));
  getIt.registerLazySingleton(
    () => CartBloc(
      addToCart: getIt(),
      getCart: getIt(),
      updateQuantity: getIt(),
      clearCart: getIt(),
    ),
  );
}