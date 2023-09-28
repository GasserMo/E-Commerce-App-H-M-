part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class PlaceOrderEvent extends CheckoutEvent {
  final CheckoutModel checkoutData;

  PlaceOrderEvent(this.checkoutData);

  @override
  List<Object?> get props => [checkoutData];
}
