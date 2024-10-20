import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'features/checkout/presentation/views/pages/my_cart_view.dart';

void main() {
  Stripe.publishableKey =
      'pk_test_51PuwSg07toYHi9WxFOBM2SUj31IuWP5U9MW8FZYeTv0PoI5Q2lSKSLX6exulZfcshhioGT868oPpHcThgLa5btpS00ndZ3uUvW';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyCartView(),
    );
  }
}
