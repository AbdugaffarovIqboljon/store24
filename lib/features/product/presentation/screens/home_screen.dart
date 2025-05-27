import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/product/presentation/bloc/product_bloc.dart';
import 'package:store24_technical_task/features/product/presentation/screens/widgets/home_tab_bar.dart';
import 'package:store24_technical_task/features/product/presentation/screens/widgets/product_content.dart';
import '../../domain/entities/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<int?> _selectedTabIndex = ValueNotifier<int?>(null);
  final ValueNotifier<List<String>> _categories =
      ValueNotifier<List<String>>([]);
  final ValueNotifier<List<Category>> _categoryList =
      ValueNotifier<List<Category>>([]);

  @override
  void initState() {
    super.initState();
    if (_categories.value.isEmpty) {
      context.read<ProductBloc>().add(FetchProductsEvent());
      context.read<ProductBloc>().add(FetchCategoriesEvent());
    }
  }

  @override
  void dispose() {
    _selectedTabIndex.dispose();
    _categories.dispose();
    _categoryList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is CategoriesLoaded) {
          _categoryList.value = state.categories;
          _categories.value =
              state.categories.map((category) => category.name).toList();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF2D2),
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 150),
          child: ValueListenableBuilder<List<String>>(
            valueListenable: _categories,
            builder: (context, categories, child) {
              return categories.isEmpty
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : HomeTabBar(
                      categories: categories,
                      selectedTabIndex: _selectedTabIndex,
                      categoryList: _categoryList.value,
                    );
            },
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF0ABAB5),
                        ),
                      );
                    } else if (state is ProductError) {
                      return const Center(
                        child: Text('Error loading products'),
                      );
                    } else if (state is ProductLoaded) {
                      return ProductContent(products: state.products);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
