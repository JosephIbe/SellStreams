import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllMovies extends MoviesEvent {}

class FetchOneMovie extends MoviesEvent {
  final String movieId;
  FetchOneMovie({@required this.movieId});

  @override
  List<Object> get props => [movieId];

}