import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllCartItems extends CartEvent {}

class AddToCartItems extends CartEvent {
  final String movieId;
  AddToCartItems({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class DeleteOneCartItem extends CartEvent {
  final String movieId;
  DeleteOneCartItem({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}

class DeleteAllCartItems extends CartEvent {}