import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: AssetImage("assets/images/img_empty_cart_case.png"),
            height: 180,
            width: 180,
          ),
          SizedBox(height: 20),
          Text(
            'Список пуст',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF94969C),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'У вас нет товаров в корзине',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF94969C),
            ),
          ),
        ],
      ),
    );
  }
}