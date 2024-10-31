import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/core/constants/api_keys.dart';
import 'package:payment/core/utils/stripe_service.dart';
import 'package:payment/features/checkout/data/models/paypal/amount_model/amount_model.dart';
import 'package:payment/features/checkout/data/models/paypal/items_list_model/item.dart';
import 'package:payment/features/checkout/data/models/paypal/items_list_model/items_list_model.dart';

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
              var transactionsData = getTransactionsData();
              executePaypalPayment(context, transactionsData);

              // ظ  // BlocProvider.of<PaymentCubit>(context).makePayment(
              //   //     paymentIntentInputModel: PaymentIntentInputModel(
              //   //   amount: '100',
              //   //   currency: 'USD',
              //   //   customerId: 'cus_R4pOX9ddbFiuZz',
              //   //   //customerId: customerId.toString(),
              //   // ));
            },
            text: "Continue");
      },
    );
  }

  void executePaypalPayment(BuildContext context,
      ({AmountModel amount, ItemsListModel itemsList}) transactionsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clintId,
        secretKey: ApiKeys.paypalSecretKey,
        transactions: [
          {
            "amount": transactionsData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionsData.itemsList.toJson(),
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
  }

  ({AmountModel amount, ItemsListModel itemsList}) getTransactionsData() {
    var amount = AmountModel(
      currency: "USD",
      details: Details(subtotal: "100", shipping: "0", shippingDiscount: 0),
      total: '100',
    );
    List<OrderItemModel> items = [
      OrderItemModel(
        currency: "USD",
        name: "Apple",
        price: "4",
        quantity: 10,
      ),
      OrderItemModel(
        currency: "USD",
        name: "Apple",
        price: "5",
        quantity: 12,
      ),
    ];
    ItemsListModel itemsList = ItemsListModel(items: items);
    return (amount: amount, itemsList: itemsList);
  }
}
