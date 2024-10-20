import 'package:flutter/material.dart';

import 'custom_buttton.dart';
import 'order_info_item.dart';
import 'payment_methods_bottom_sheet.dart';
import 'total_price.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Expanded(
            child: Image.asset(
              "assets/images/basket_image.png",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 25),
          const OrderInfoItem(title: 'Order Subtotal', value: '\$42.97'),
          const SizedBox(height: 3),
          const OrderInfoItem(title: 'Discount', value: '\$0'),
          const SizedBox(height: 3),
          const OrderInfoItem(title: 'Shipping', value: '\$8'),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              thickness: 4,
              height: 34,
              color: Color(0xFFC6C6C6),
            ),
          ),
          const TotalPrice(title: 'Total', value: '\$50.97'),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Complete Payment',
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                context: context,
                builder: (context) {
                  return const PaymentMethodsBottomSheet();
                },
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

