import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/core/utils/stripe_service.dart';

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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => PaypalCheckoutView(
                  sandboxMode: true,
                  clientId: "1",
                  secretKey:
                      "EHIL-oH5RJPt_a_6b3irLIsa7bVJ9qbU0O20XN9_lRsMdwGyhyloGY_N1ougtuxgvmc4g5H2LfTVtGeD",
                  transactions: const [
                    {
                      "amount": {
                        "total": '100',
                        "currency": "USD",
                        "details": {
                          "subtotal": '100',
                          "shipping": '0',
                          "shipping_discount": 0
                        }
                      },
                      "description": "The payment transaction description.",
                      // "payment_options": {
                      //   "allowed_payment_method":
                      //       "INSTANT_FUNDING_SOURCE"
                      // },
                      "item_list": {
                        "items": [
                          {
                            "name": "Apple",
                            "quantity": 4,
                            "price": '10',
                            "currency": "USD"
                          },
                          {
                            "name": "Pineapple",
                            "quantity": 5,
                            "price": '12',
                            "currency": "USD"
                          }
                        ],

                        // Optional
                        //   "shipping_address": {
                        //     "recipient_name": "Tharwat samy",
                        //     "line1": "tharwat",
                        //     "line2": "",
                        //     "city": "tharwat",
                        //     "country_code": "EG",
                        //     "postal_code": "25025",
                        //     "phone": "+00000000",
                        //     "state": "ALex"
                        //  },
                      }
                    }
                  ],
                  note: "Contact us for any questions on your order.",
                  onSuccess: (Map params) async {
                    log("onSuccess: $params");
                    Navigator.pop(context);
                  },
                  onError: (error) {
                    log("onError: $error");
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    print('cancelled:');
                    Navigator.pop(context);
                  },
                ),
              ));

              // BlocProvider.of<PaymentCubit>(context).makePayment(
              //     paymentIntentInputModel: PaymentIntentInputModel(
              //   amount: '100',
              //   currency: 'USD',
              //   customerId: 'cus_R4pOX9ddbFiuZz',
              //   //customerId: customerId.toString(),
              // ));
            },
            text: "Continue");
      },
    );
  }
}
