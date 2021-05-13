import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:sell_streams/data/models/movie_model.dart';

@immutable
abstract class MoviesState extends Equatable{
  @override
  List<Object> get props => [];
}

class MoviesStateInitial extends MoviesState {}

class MoviesStateLoading extends MoviesState {}

class MoviesStateSuccess extends MoviesState {
  final List<Movies> moviesList;
  MoviesStateSuccess({@required this.moviesList});

  @override
  List<Object> get props => [moviesList];

}

class MoviesStateFailure extends MoviesState {
  final String errorMessage;
  MoviesStateFailure({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}