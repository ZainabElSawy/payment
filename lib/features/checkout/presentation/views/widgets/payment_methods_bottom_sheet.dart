import 'package:flutter/material.dart';

import 'custom_buttton.dart';
import 'payment_methods_list_view.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          const PaymentMethodsListView(),
          const SizedBox(height: 32),
          CustomButton(onTap: () {
            
          }, text: "Continue")
        ],
      ),
    );
  }
}
