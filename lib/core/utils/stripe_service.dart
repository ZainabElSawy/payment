import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/core/constants/api_keys.dart';
import 'package:payment/core/utils/api_service.dart';
import '../../features/checkout/data/models/stripe/ephemeral_key_model/ephemeral_key_model.dart';
import '../../features/checkout/data/models/stripe/init_payment_sheet_input_model/init_payment_sheet_input_model.dart';
import '../../features/checkout/data/models/stripe/payment_intent_input_model/payment_intent_input_model.dart';
import '../../features/checkout/data/models/stripe/payment_intent_model/payment_intent_model.dart';

class StripeService {
  /*
    Future<PaymentIntentModel> create payment intent (amount , currency)
    init payment sheet (paymentIntentClientSecret)
    presentPaymentSheet()
  */

  final ApiService apiService = ApiService();
  Future<String> createCustomer() async {
    Response response = await apiService.post(
      body: {},
      url: 'https://api.stripe.com/v1/customers',
      token: ApiKeys.secretKey,
    );
    log("${response.data["id"]}");
    return response.data["id"];
    //!Important

    //*Make it during login success and save it in shared preference
    //*clean it after logout

    //? String? customerId;
    //? getCustomerId() async {
    //?   customerId = await StripeService().createCustomer();
    //? }

    //? @override
    //? void initState() {
    //?   getCustomerId();
    //?   super.initState();
    //? }
  }

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    Response response = await apiService.post(
      contentType: Headers.formUrlEncodedContentType,
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretKey,
    );

    PaymentIntentModel paymentIntentModel =
        PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    Response response = await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: {'customer': customerId},
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secretKey,
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          "Stripe-Version": "2024-06-20",
        });

    EphemeralKeyModel ephemeralKeyModel =
        EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyModel;
  }

  Future initPaymentSheet(
      {required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
      customerId: initPaymentSheetInputModel.customerId,
      customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKeySecret,
      merchantDisplayName: "Zainab Hamdy",
    ));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    PaymentIntentModel paymentIntent =
        await createPaymentIntent(paymentIntentInputModel);
    EphemeralKeyModel ephemeralKeyModel = await createEphemeralKey(
        customerId: paymentIntentInputModel.customerId);

    await initPaymentSheet(
        initPaymentSheetInputModel: InitPaymentSheetInputModel(
      clientSecret: paymentIntent.clientSecret!,
      customerId: paymentIntentInputModel.customerId,
      ephemeralKeySecret: ephemeralKeyModel.secret!,
    ));
    await displayPaymentSheet();
  }
}
