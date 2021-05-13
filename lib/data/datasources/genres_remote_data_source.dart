import 'package:flutter/material.dart';
import 'package:sell_streams/data/core/api_client.dart';
import 'package:sell_streams/data/models/genres_model.dart';
import 'package:sell_streams/data/models/genres_response_model.dart';

abstract class GenresRemoteDataSource {
  Future<List<GenresModel>> getAllGenres();
}

class GenresRemoteDataSourceImpl implements GenresRemoteDataSource {

  APIClient client;
  GenresRemoteDataSourceImpl({@required this.client});

  List<GenresModel> _genresList = [];

  @override
  Future<List<GenresModel>> getAllGenres() async {
    final response =
      await client.getListOfModelItems(
          url: 'https://academician-api.herokuapp.com/api/v1/genres/fetch-all-genres'
      );
    _genresList = GenresResponseModel.fromJson(response).genres;
    return _genresList;
  }

}