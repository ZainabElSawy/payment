part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentNetworkFailure extends PaymentState {
  final String errMessage;

  PaymentNetworkFailure(this.errMessage);
}

final class PaymentServerFailure extends PaymentState {
  final String errMessage;

  PaymentServerFailure(this.errMessage);
}
