import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/app/screens/main_screen.dart';
import 'package:store24_technical_task/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:store24_technical_task/injection_container.dart' as sl;
import '../../features/product/presentation/bloc/product_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.getIt<ProductBloc>()),
        BlocProvider(create: (_) => sl.getIt<CartBloc>()),
      ],
      child: MaterialApp(
        title: 'Drink App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFFFFFFF),
            scrolledUnderElevation: 0,
          ),
          scaffoldBackgroundColor: Color(0xFFFFFFFF),
        ),
        initialRoute: '/',
        home: const MainScreen(),
      ),
    );
  }
}
