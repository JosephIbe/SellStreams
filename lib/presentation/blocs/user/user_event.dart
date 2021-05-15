import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:sell_streams/data/models/user_model.dart';

@immutable
abstract class UserEvent extends Equatable {

  @override
  List<Object> get props => [];

}

class GetUserProfileDetails extends UserEvent {}

class UpdateUserProfileDetails extends UserEvent {

  final dynamic body;
  UpdateUserProfileDetails({@required this.body});

  @override
  List<Object> get props => [body];

}