import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sell_streams/domain/repositories/genres_repository.dart';

import 'genres.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {

  final GenresRepository _genresRepository;
  GenresBloc(GenresRepository repository)
      : assert (repository != null),
        _genresRepository = repository,
        super(GenresStateInitial());

  @override
  Stream<GenresState> mapEventToState(GenresEvent event) async* {
    if (event is FetchAllGenres) {
      yield* _mapFetchAllGenresToState(event);
    }

    if (event is FetchMoviesInGenre) {
      yield* _mapFetchMoviesInGenreToState(event);
    }
  }

  Stream<GenresState> _mapFetchAllGenresToState(FetchAllGenres event) async* {
    yield GenresStateLoading();
    try {
      final response = await _genresRepository.getAllGenres();
      if(response.isNotEmpty) {
        print('response \n $response');
        yield GenresStateItemsLoadSuccess(allGenres: response);
      } else {
        print('empty response \n $response');
        yield GenresStateFailure(errorMessage: 'Error Fetching All Genres, Try Again!');
      }
    } catch (err){
      print(err);
      yield GenresStateFailure(errorMessage: 'Error Fetching All Genres, Try Again!');
    }
  }

  Stream<GenresState> _mapFetchMoviesInGenreToState(FetchMoviesInGenre event) async* {}
}
