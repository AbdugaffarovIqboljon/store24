import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store24_technical_task/app/screens/app.dart';
import 'injection_container.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await sl.init();
  runApp(const MyApp());
}

