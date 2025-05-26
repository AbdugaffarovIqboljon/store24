import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/app/screens/main_screen.dart';
import 'package:store24_technical_task/injection_container.dart' as sl;
import '../../features/product/presentation/bloc/product_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.getIt<ProductBloc>()),
        // BlocProvider(create: (_) => di.sl<CartBloc>),
      ],
      child: MaterialApp(
        title: 'Drink App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        home: const MainScreen(),
      ),
    );
  }
}
