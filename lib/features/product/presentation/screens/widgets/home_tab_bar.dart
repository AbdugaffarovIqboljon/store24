import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store24_technical_task/features/product/domain/entities/category.dart';

import '../../bloc/product_bloc.dart';
import 'category_tab_widget.dart';

class HomeTabBar extends StatelessWidget {
  final List<String> categories;
  final ValueNotifier<int?> selectedTabIndex;
  final List<Category> categoryList;

  const HomeTabBar({
    super.key,
    required this.categories,
    required this.selectedTabIndex,
    required this.categoryList,
  });

  static const LinearGradient _orangeGradient = LinearGradient(
    colors: [Color(0xFFFFEF01), Color(0xFFFFC900)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        gradient: _orangeGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
        child: ValueListenableBuilder<int?>(
          valueListenable: selectedTabIndex,
          builder: (context, selectedIndex, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  return CategoryTabWidget(
                    text: categories[index],
                    isSelected: selectedIndex != null && index == selectedIndex,
                    onTap: () {
                      selectedTabIndex.value = index;
                      final selectedCategory = categoryList[index];
                      context.read<ProductBloc>().add(
                            FetchProductsByCategoryEvent(selectedCategory.slug),
                          );
                    },
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
