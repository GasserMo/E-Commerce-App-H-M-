import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/constants.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/product_model.dart';
import 'package:store/repositiries/checkout/repository.dart';
import 'package:store/repositiries/local%20storage/Cart%20storage/cart_storage_repository.dart';
import 'package:store/repositiries/local%20storage/Cart%20storage/cart_repositiry.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FireStoreCart _firebaseCart; // Reference to FirebaseRepository

  CartBloc({required FireStoreCart fireStoreCart})
      : _firebaseCart = fireStoreCart,
        super(CartLoading()) {
    on<LoadCart>(onLoadCart);
    on<AddProduct>(onAddProduct);
    on<RemoveProduct>(onRemoveProduct);
    on<ClearCart>(_onClearCart);
  }

  void onLoadCart(event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Use currentUser.uid to fetch the cart data from Firestore
        final cartData =
            await _firebaseCart.fetchCartDataFromFirestore(currentUser.uid);
        emit(CartLoaded(cart: cartData));
      }
    } on Exception {
      emit(CartError());
    }
  }

  void onAddProduct(event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      final updatedCart = Cart(
        products: List.from(state.cart.products)..add(event.product),
      );
      try {
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          await _firebaseCart.saveCartDataToFirestore(
              currentUser.uid, updatedCart);
        }
        emit(CartLoaded(cart: updatedCart));
      } on Exception {
        emit(CartError());
      }
    }
  }

  void onRemoveProduct(event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        try {
          await _firebaseCart.removeProductFromCart(
            currentUser.uid,
            event.product.name, // Use the product's name
          );

          // Create an updated cart without the removed product by matching the name
          final updatedProducts = state.cart.products
              .where((product) => product.name != event.product.name)
              .toList();
          final updatedCart = Cart(products: updatedProducts);

          emit(CartLoaded(cart: updatedCart));
        } catch (e) {
          emit(CartError());
        }
      }
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    try {
      await _firebaseCart.deleteCart(currentUser.uid);

      // Clear the cart state
      emit(CartLoaded(cart: Cart(products: [])));
    } catch (e) {
      emit(CartError());
    }
  }
}
}