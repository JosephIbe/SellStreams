import 'package:flutter/material.dart';
import 'package:sell_streams/data/core/api_client.dart';
import 'package:sell_streams/data/models/movie_model.dart';
import 'package:sell_streams/data/models/movie_response_model.dart';


abstract class MovieRemoteDataSource {
  Future<List<Movies>> getAllMovies();
  Future<Movies> getSingleMovie(String movieId);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {

  APIClient client;
  MovieRemoteDataSourceImpl({@required this.client});

  List<Movies> _moviesList = [];

  @override
  Future<List<Movies>> getAllMovies() async {
    final response =
      await client.getListOfModelItems(
        url: 'https://academician-api.herokuapp.com/api/v1/movies/fetch-all-movies'
      );
    _moviesList = MovieResponseModel.fromJson(response).movies;
    return _moviesList;
  }

  @override
  Future<Movies> getSingleMovie(String movieId) async {
  }

}