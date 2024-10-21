import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:payment/core/errors/failure.dart';
import 'package:payment/features/checkout/data/data_source/checkout_datasource.dart';
import 'package:payment/features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:payment/features/checkout/domain/repo/checkout_repo.dart';

class CheckoutRepoImp extends CheckoutRepo {
  final CheckoutDataSource checkoutDataSource;
  CheckoutRepoImp(this.checkoutDataSource);
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await checkoutDataSource.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      // ignore: deprecated_member_use
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
