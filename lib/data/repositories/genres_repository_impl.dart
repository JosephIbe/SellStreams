import 'package:flutter/material.dart';
import 'package:sell_streams/data/datasources/genres_remote_data_source.dart';
import 'package:sell_streams/data/models/genres_model.dart';
import 'package:sell_streams/domain/repositories/genres_repository.dart';

class GenresRepositoryImpl extends GenresRepository {

  GenresRemoteDataSource dataSource;
  GenresRepositoryImpl({@required this.dataSource});

  @override
  Future<List<GenresModel>> getAllGenres() async {
    return await dataSource.getAllGenres();
  }

}