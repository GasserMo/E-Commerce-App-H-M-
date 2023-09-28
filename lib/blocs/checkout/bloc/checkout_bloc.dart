import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:store/models/checkout_model.dart';
import 'package:store/repositiries/checkout/repository.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final FirestoreRepository
      _firebaseRepository; // Reference to FirebaseRepository

  CheckoutBloc({
    required FirestoreRepository firebaseRepository,
  })  : _firebaseRepository = firebaseRepository,
        super(CheckoutInitial()) {
    on<PlaceOrderEvent>(_onPlaceOrder);
  }

  void _onPlaceOrder(PlaceOrderEvent event, Emitter<CheckoutState> emit) {
    emit(CheckoutLoading());
    try {
      // Place the order in Firebase Firestore
      _firebaseRepository.placeOrder(event.checkoutData);

      emit(CheckoutSuccess());
    } catch (e) {
      emit(CheckoutFailure('Failed to place the order: $e'));
    }
  }
}
