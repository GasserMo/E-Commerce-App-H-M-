part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

 
}

class LoadFavorite extends FavoriteEvent{
   @override
  List<Object> get props => [];
}
class AddProductToFavorite extends FavoriteEvent{

 final Product product;

  AddProductToFavorite(this.product);
 @override
  List<Object> get props => [product];
}

class RemoveProductFromFavorite extends FavoriteEvent{
  final Product product;

  RemoveProductFromFavorite(this.product);
  @override
  List<Object> get props => [product];
}
class ClearFavorite extends FavoriteEvent{
  final Product product;

  ClearFavorite(this.product);
  @override
  List<Object> get props => [product];
}