import 'package:flutter/material.dart';
import 'package:sell_streams/data/core/api_client.dart';
import 'package:sell_streams/data/models/cart_response_model.dart';
import 'package:sell_streams/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> addMovieToCart(String movieId);
  Future<void> removeMovieFromCart(String movieId);
  Future<List<CartModel>> getAllCartItems();
  Future<void> clearCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {

  APIClient client;
  CartRemoteDataSourceImpl({@required this.client});

  List<CartModel> _cartList = [];

  @override
  Future<CartModel> addMovieToCart(String movieId) async {
    return await client.addCartItem(resource: 'add-item', body: movieId);
  }

  @override
  Future<List<CartModel>> getAllCartItems() async {
    final response =
    await client.getListOfModelItems(
        url: 'https://academician-api.herokuapp.com/api/v1/cart/list-cart'
    );
    _cartList = CartResponseModel.fromJson(response).cart;
    return _cartList;
  }

  @override
  Future<void> removeMovieFromCart(String movieId) async {
    await client.deleteCartItem(resource: 'delete-item',  body: movieId);
  }

  @override
  Future<void> clearCart() async {
    await client.deleteAllCartItems(resource: 'clear-cart');
  }

}