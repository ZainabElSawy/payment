import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/payment_details_view_body.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Payment Details'),
      body: PaymentDetailsViewBody(),
    );
  }
}
