import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/my_cart_view_body.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'My Cart'),
      body: MyCartViewBody(),
    );
  }
}
