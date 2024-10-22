import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:payment/features/checkout/domain/repo/checkout_repo.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/models/stripe/payment_intent_input_model/payment_intent_input_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    var result = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    result.fold((failure) {
      if (failure is ServerFailure) {
        emit(PaymentServerFailure(failure.errorMessage));
      } else if (failure is NetworkFailure) {
        emit(PaymentNetworkFailure(failure.errorMessage));
      }
    }, (success) {
      emit(PaymentSuccess());
    });
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
