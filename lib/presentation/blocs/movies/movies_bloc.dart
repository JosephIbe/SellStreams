import 'dart:async';

import 'package:sell_streams/domain/repositories/movie_repository.dart';

import 'package:bloc/bloc.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  final MovieRepository _movieRepository;
  MoviesBloc(MovieRepository repository)
      : assert (repository != null),
        _movieRepository = repository,
        super(MoviesStateInitial());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if(event is FetchAllMovies) {
      yield* _mapFetchAllMoviesToState(event);
    }
    if (event is FetchOneMovie) {
      yield* _mapFetchOneMovieToState(event);
    }
  }

  Stream<MoviesState> _mapFetchAllMoviesToState(FetchAllMovies event) async* {
    yield MoviesStateLoading();
    try {
      final response = await _movieRepository.getAllMovies();
      if(response.isNotEmpty) {
        print('response \n $response');
        yield MoviesStateSuccess(moviesList: response);
      } else {
        print('empty response \n $response');
        yield MoviesStateFailure(errorMessage: 'Error Fetching All Movies, Try Again!');
      }
    } catch (err){
      print(err);
      yield MoviesStateFailure(errorMessage: 'Error Fetching All Movies, Try Again!');
    }
  }

  Stream<MoviesState> _mapFetchOneMovieToState(FetchOneMovie event) async* {}
}