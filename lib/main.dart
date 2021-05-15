import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sell_streams/presentation/blocs/authentication/auth.dart';

import 'package:sell_streams/presentation/journeys/auth/login.dart';
import 'package:sell_streams/presentation/journeys/landing.dart';

import 'package:sell_streams/utils/router.dart';

import 'data/repositories/genres_repository_impl.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';

import 'domain/repositories/genres_repository.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/repositories/cart_repository.dart';

import 'package:pedantic/pedantic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_streams/di/get_it.dart' as getIt;

import 'presentation/blocs/genres/genres.dart';
import 'presentation/blocs/movies/movies.dart';
import 'presentation/blocs/user/user.dart';
import 'presentation/blocs/cart/cart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(getIt.init());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) =>
    runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<UserRepository>(
              create: (context) => UserRepositoryImpl(dataSource: getIt.getItInstance()),
            ),
            RepositoryProvider<MovieRepository>(
              create: (context) => MovieRepositoryImpl(dataSource: getIt.getItInstance()),
            ),
            RepositoryProvider<GenresRepository>(
              create: (context) => GenresRepositoryImpl(dataSource: getIt.getItInstance()),
            ),
            RepositoryProvider<CartRepository>(
              create: (context) => CartRepositoryImpl(dataSource: getIt.getItInstance()),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context){
                  final userRepo = context.read<UserRepository>();
                  return AuthenticationBloc(userRepo)..add(AppStarted());
                },
              ),
              BlocProvider<UserBloc>(
                create: (context){
                  final userRepo = context.read<UserRepository>();
                  return UserBloc(userRepo)..add(GetUserProfileDetails());
                },
              ),
              BlocProvider<MoviesBloc>(
                create: (context){
                  final repo = context.read<MovieRepository>();
                  return MoviesBloc(repo)..add(FetchAllMovies());
                },
              ),
              BlocProvider<GenresBloc>(
                create: (context){
                  final repo = context.read<GenresRepository>();
                  return GenresBloc(repo)..add(FetchAllGenres());
                },
              ),
              BlocProvider<CartBloc>(
                create: (context){
                  final repo = context.read<CartRepository>();
                  return CartBloc(repo)..add(FetchAllCartItems());
                },
              ),
            ],
            child: SellStreamsApp(),
          ),
        )
    )
  );

}

class SellStreamsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SellStreams',
      theme: ThemeData(
        primaryColor: Color(0xFF4d4ba8),
        primaryColorDark: Color(0xFF252443),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          // print(state);
          if(state is AuthenticationStateAuthenticated) {
            return Landing();
          }
          return LoginView();
        }
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}