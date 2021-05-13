import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sell_streams/data/models/user_model.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserStateInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateSuccess extends UserState {
  final UserModel user;
  UserStateSuccess({@required this.user});

  @override
  List<Object> get props => [user];
}

class UserStateFailure extends UserState {
  final String errorMessage;
  UserStateFailure({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

}