import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:sell_streams/data/models/genres_model.dart';

@immutable
abstract class GenresState extends Equatable {
  @override
  List<Object> get props => [];
}

class GenresStateInitial extends GenresState {}

class GenresStateLoading extends GenresState {}

class GenresStateItemsLoadSuccess extends GenresState {
  final List<GenresModel> allGenres;
  GenresStateItemsLoadSuccess({@required this.allGenres});

  @override
  List<Object> get props => [allGenres];

}

class GenresStateFailure extends GenresState {
  final String errorMessage;
  GenresStateFailure({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}