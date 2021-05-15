import 'package:sell_streams/data/core/api_client.dart';

import 'package:sell_streams/data/datasources/cart_remote_data_source.dart';
import 'package:sell_streams/data/datasources/genres_remote_data_source.dart';
import 'package:sell_streams/data/datasources/movie_remote_data_source.dart';
import 'package:sell_streams/data/datasources/user_remote_data_source.dart';

import 'package:sell_streams/data/repositories/cart_repository_impl.dart';
import 'package:sell_streams/data/repositories/genres_repository_impl.dart';
import 'package:sell_streams/data/repositories/movie_repository_impl.dart';
import 'package:sell_streams/data/repositories/user_repository_impl.dart';

import 'package:sell_streams/domain/repositories/cart_repository.dart';
import 'package:sell_streams/domain/repositories/genres_repository.dart';
import 'package:sell_streams/domain/repositories/movie_repository.dart';
import 'package:sell_streams/domain/repositories/user_repository.dart';

import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future init(){
  getItInstance.registerLazySingleton<APIClient>(() => APIClient());

  getItInstance.registerLazySingleton<UserRemoteDataSource>(
          () => UserRemoteDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(dataSource: getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(
          () => MovieRepositoryImpl(dataSource: getItInstance()));

  getItInstance.registerLazySingleton<GenresRemoteDataSource>(
          () => GenresRemoteDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<GenresRepository>(
          () => GenresRepositoryImpl(dataSource: getItInstance()));

  getItInstance.registerLazySingleton<CartRemoteDataSource>(
          () => CartRemoteDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<CartRepository>(
          () => CartRepositoryImpl(dataSource: getItInstance()));

}