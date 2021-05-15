import 'package:flutter/material.dart';
import 'package:sell_streams/presentation/journeys/auth/login.dart';
import 'package:sell_streams/presentation/journeys/auth/register.dart';
import 'package:sell_streams/presentation/journeys/landing.dart';
import 'package:sell_streams/presentation/journeys/movies/movie_details.dart';
import 'package:sell_streams/presentation/journeys/profile/profile_details.dart';
import 'package:sell_streams/presentation/journeys/cart/index.dart';
import 'package:sell_streams/presentation/journeys/widgets/policy_view.dart';
import 'package:sell_streams/presentation/journeys/widgets/purchase_history.dart';
import 'package:sell_streams/utils/strings.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_)=> LoginView());
        break;
      case registerRoute:
        return MaterialPageRoute(builder: (_)=> RegisterView());
        break;
      case landingRoute:
        return MaterialPageRoute(builder: (_)=> Landing());
        break;
      case movieDetailsRoute:
        var movie = settings.arguments;
        return MaterialPageRoute(builder: (_)=> MovieDetails(movie: movie,));
        break;
      case profileDetailsRoute:
        return MaterialPageRoute(builder: (_)=> EditProfileDetails());
        break;
      case purchaseHistoryRoute:
        return MaterialPageRoute(builder: (_)=> PurchaseHistory());
        break;
      case policyRoute:
        return MaterialPageRoute(builder: (_)=> PolicyView());
        break;
      case cartRoute:
        return MaterialPageRoute(builder: (_)=> CartView());
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route specified for ${settings.name}'),
                  ),
                ));
    }
  }
}