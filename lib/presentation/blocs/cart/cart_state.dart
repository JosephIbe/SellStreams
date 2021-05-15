import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:sell_streams/data/models/cart_model.dart';

@immutable
abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartStateInitial extends CartState {}

class CartStateLoading extends CartState {}

class CartStateSuccess extends CartState {

  final CartModel itemAdded;
  final List<CartModel> cartList;
  CartStateSuccess({@required this.cartList, @required this.itemAdded});

  @override
  List<Object> get props => [cartList, itemAdded];
}

class CartStateFailure extends CartState {
  final String errorMessage;
  CartStateFailure({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}