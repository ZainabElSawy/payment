import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/core/utils/stripe_service.dart';

import '../../../data/models/payment_intent_input_model/payment_intent_input_model.dart';
import '../../manager/payment_cubit/payment_cubit.dart';
import '../pages/thank_you_view.dart';
import 'custom_buttton.dart';

class CustomButtonBlocConsumer extends StatefulWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  State<CustomButtonBlocConsumer> createState() =>
      _CustomButtonBlocConsumerState();
}

class _CustomButtonBlocConsumerState extends State<CustomButtonBlocConsumer> {
  //!Important
  //*Make it during login success and save it in shared preference
  //*clean it after logout
  String? customerId;
  getCustomerId() async {
    customerId = await StripeService().createCustomer();
  }

  @override
  void initState() {
    getCustomerId();
    super.initState();
  }

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
                  paymentIntentInputModel: PaymentIntentInputModel(
                amount: '100',
                currency: 'USD',
                customerId: 'cus_R4pOX9ddbFiuZz',
                //customerId: customerId.toString(),
              ));
            },
            text: "Continue");
      },
    );
  }
}
