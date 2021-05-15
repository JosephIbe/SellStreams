import 'package:sell_streams/data/models/cart_model.dart';

abstract class CartRepository {
  Future<CartModel> addMovieToCart({String movieId});
  Future<void> removeMovieFromCart({String movieId});
  Future<List<CartModel>> getAllCartItems();
  Future<void> clearCart();
}