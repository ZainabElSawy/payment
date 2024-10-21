import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:payment/features/checkout/presentation/manager/payment_cubit/payment_cubit.dart';

import '../pages/thank_you_view.dart';
import 'custom_buttton.dart';
import 'payment_methods_list_view.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 32),
          PaymentMethodsListView(),
          SizedBox(height: 32),
          CustomButtonBlocConsumer()
        ],
      ),
    );
  }
}

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ThankYouView(),
            ),
          );
        } else if (state is PaymentServerFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
            isLoading: state is PaymentLoading ? true : false,
            onTap: () {
              BlocProvider.of<PaymentCubit>(context).makePayment(
                  paymentIntentInputModel:
                      PaymentIntentInputModel(amount: '100', currency: 'USD'));
            },
            text: "Continue");
      },
    );
  }
}
