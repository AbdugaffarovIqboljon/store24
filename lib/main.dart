import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store24_technical_task/app/screens/app.dart';
import 'injection_container.dart' as sl;
import 'features/cart/data/models/cart_item_model.dart';
import 'features/product/data/models/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Delete Hive storage to clear all corrupted data
  await Hive.deleteFromDisk();

  // Reinitialize Hive with adapters
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  final box = await Hive.openBox<CartItemModel>('cartBox');
  await box.clear(); // Ensure the box is empty on startup
  print('Hive box initialized and cleared, length: ${box.length}');

  await sl.init();
  runApp(const MyApp());
}