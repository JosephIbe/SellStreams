import 'package:sell_streams/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<Movies>> getAllMovies();
  Future<Movies> getSingleMovie(String movieId);
}