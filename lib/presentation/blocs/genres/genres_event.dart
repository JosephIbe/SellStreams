import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

@immutable
abstract class GenresEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAllGenres extends GenresEvent {}

class FetchMoviesInGenre extends GenresEvent {
  final String genreId;
  FetchMoviesInGenre({@required this.genreId});

  @override
  List<Object> get props => [genreId];

}
