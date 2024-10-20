import 'package:flutter/material.dart';
import '../pages/thank_you_view.dart';
import 'custom_buttton.dart';
import 'custom_credit_card.dart';
import 'payment_methods_list_view.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  const PaymentDetailsViewBody({super.key});

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: PaymentMethodsListView()),
        SliverToBoxAdapter(
            child: CustomCreditCard(
          autovalidateMode: autovalidateMode,
          formKey: formKey,
        )),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12, right: 16, left: 16),
              child: CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ThankYouView(),
                    ));
                    setState(() {});
                  }
                },
                text: 'Payment',
              ),
            ),
          ),
        )
      ],
    );
  }
}
