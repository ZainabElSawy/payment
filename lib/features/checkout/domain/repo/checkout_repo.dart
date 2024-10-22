import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/stripe/payment_intent_input_model/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
