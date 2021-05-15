import 'package:flutter/material.dart';

import 'package:sell_streams/data/models/cart_model.dart';
import 'package:sell_streams/data/datasources/cart_remote_data_source.dart';

import 'package:sell_streams/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {

  CartRemoteDataSource dataSource;
  CartRepositoryImpl({@required this.dataSource});

  @override
  Future<CartModel> addMovieToCart({String movieId}) async {
    return await dataSource.addMovieToCart(movieId);
  }

  @override
  Future<List<CartModel>> getAllCartItems() async {
    return await dataSource.getAllCartItems();
  }

  @override
  Future<void> removeMovieFromCart({String movieId}) async {
    await dataSource.removeMovieFromCart(movieId);
  }

  @override
  Future<void> clearCart() async {
    await dataSource.clearCart();
  }

}