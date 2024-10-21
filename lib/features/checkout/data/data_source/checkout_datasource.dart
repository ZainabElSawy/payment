import 'package:payment/core/utils/stripe_service.dart';

import '../models/payment_intent_input_model/payment_intent_input_model.dart';

abstract class CheckoutDataSource {
  Future<void> makePayment({required PaymentIntentInputModel paymentIntentInputModel});
}
class CheckoutDataSourceImpl extends CheckoutDataSource {
  final StripeService stripeService = StripeService();
  @override
  Future<void> makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async{
    await stripeService.makePayment(paymentIntentInputModel: paymentIntentInputModel);
  }
}