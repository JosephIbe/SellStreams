import 'package:flutter/material.dart';
import 'package:sell_streams/data/datasources/movie_remote_data_source.dart';
import 'package:sell_streams/data/models/movie_model.dart';
import 'package:sell_streams/domain/repositories/movie_repository.dart';


class MovieRepositoryImpl extends MovieRepository {

  MovieRemoteDataSource dataSource;
  MovieRepositoryImpl({@required this.dataSource});

  @override
  Future<List<Movies>> getAllMovies() async {
    return await dataSource.getAllMovies();
  }

  @override
  Future<Movies> getSingleMovie(String movieId) async {
  }

}