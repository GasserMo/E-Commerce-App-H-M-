import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:store/blocs/cart/bloc/cart_bloc.dart';
import 'package:store/models/favorite_model.dart';
import 'package:store/models/product_model.dart';
import 'package:store/repositiries/local%20storage/Fav%20storage/fav_storage_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FireStoreFavorite _fireStoreFavorite;
  FavoriteBloc({required FireStoreFavorite fireStoreFavorite})
      : _fireStoreFavorite = fireStoreFavorite,
        super(FavoriteLoading()) {
    on<LoadFavorite>(onLoadFavorite);
    on<AddProductToFavorite>(onAddProduct);
    on<ClearFavorite>(onClearFavorite);

    on<RemoveProductFromFavorite>(onRemoveProduct);
  }
  void onLoadFavorite(event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Use currentUser.uid to fetch the cart data from Firestore
        final favData =
            await _fireStoreFavorite.fetchFavDataFromFirestore(currentUser.uid);
        emit(FavoriteLoaded(favorite: favData));
      }
    } on Exception {
      emit(FavoriteError());
    }
  }

  void onAddProduct(event, Emitter<FavoriteState> emit) async {
    final state = this.state;
    if (state is FavoriteLoaded) {
      final updatedFavorites = Favorite(
          products: List.from(state.favorite.products)..add(event.product));

      try {
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          await _fireStoreFavorite.saveFavDataToFirestore(
              currentUser.uid, updatedFavorites);
        }
        emit(FavoriteLoaded(favorite: updatedFavorites));
      } on Exception {
        emit(FavoriteError());
      }
    }
  }

  void onRemoveProduct(event, Emitter<FavoriteState> emit) async {
    final state = this.state;
    if (state is FavoriteLoaded) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        try {
          await _fireStoreFavorite.removeProductFromFav(
            currentUser.uid,
            event.product.name, // Use the product's name
          );

          // Create an updated cart without the removed product by matching the name
          final updatedProducts = state.favorite.products
              .where((product) => product.name != event.product.name)
              .toList();
          final updatedFav = Favorite(products: updatedProducts);

          emit(FavoriteLoaded(favorite: updatedFav));
        } catch (e) {
          emit(FavoriteError());
        }
      }
    }
  }

  void onClearFavorite(ClearFavorite event, Emitter<FavoriteState> emit) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    try {
      await _fireStoreFavorite.deleteCart(currentUser.uid);
          emit(FavoriteLoaded(favorite: Favorite(products: [])));

    }catch (e) {
     emit(FavoriteError());
    }
  }
}
}