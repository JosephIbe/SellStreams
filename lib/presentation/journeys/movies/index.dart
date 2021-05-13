import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_streams/data/models/movie_model.dart';
import 'package:sell_streams/presentation/blocs/movies/movies.dart';
import 'package:sell_streams/presentation/journeys/widgets/loader_widget.dart';
import 'package:sell_streams/presentation/journeys/widgets/movie_item_card.dart';
import 'package:sell_streams/utils/constants.dart';
import 'package:sell_streams/utils/strings.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  double w, h;

  @override
  Widget build(BuildContext context) {

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: w,
          height: h,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: h * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(welcomeTxt, style: kSectionHeaderTextStyle, textAlign: TextAlign.start,),
                                Text(bookFavoriteMovieTxt, style: kSubHeaderTextStyle, textAlign: TextAlign.start,),
                              ],
                            ),
                            Container(
                              height: h * 0.08,
                              width:  60.0,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle
                              ),
                            )
                          ],
                        )
                      ],
                    )
                ),
                SizedBox(height: 20.0,),

                Container(
                  height: h * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.9),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Center(
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: 'Explore...',
                          hintStyle: GoogleFonts.lato(textStyle: TextStyle(color: Colors.white, letterSpacing: 0.5, fontSize: 18.0)),
                          prefixIcon: Icon(Icons.search_off_sharp, color: Colors.white,),
                          suffixIcon: Icon(Icons.mic, color: Colors.white,),
                          border: InputBorder.none
                      ),
                    ),
                  )
                ),
                SizedBox(height: 20.0,),

                Text('Featured Movies', style: kSectionHeaderTextStyle, textAlign: TextAlign.start,),
                BlocListener<MoviesBloc, MoviesState>(
                  listener: (context, state){
                    print('movies state listening $state');
                    if(state is MoviesStateSuccess){
                      return MoviesList(items: state.moviesList);
                    }
                    if (state is MoviesStateFailure){
                      return Container(
                        width: w,
                        height: h * 0.55,
                        child: Center(
                          child: Text(state.errorMessage),
                        ),
                      );
                    }
                    return Center(child: AppLoader(text: 'Fetching Movies'),);
                  },
                  child: BlocBuilder<MoviesBloc, MoviesState>(
                    builder: (context, state){
                      print('movies state building $state');
                      if(state is MoviesStateSuccess){
                        return MoviesList(items: state.moviesList);
                      }
                      if (state is MoviesStateFailure){
                        return Container(
                          width: w,
                          height: h * 0.55,
                          child: Center(
                            child: Text(state.errorMessage),
                          ),
                        );
                      }
                      return AppLoader(text: 'Fetching Movies');
                    }
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

class MoviesList extends StatelessWidget {

  final List<Movies> items;
  MoviesList({@required this.items});

  double w, h;

  @override
  Widget build(BuildContext context) {

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return CarouselSlider(
      items: items.map((movie) => GestureDetector(
        onTap: ()=> Navigator.pushNamed(context, movieDetailsRoute, arguments: movie),
        child: MovieItemCard(title: movie.title, imgURL: movie.imageURL, rating: movie.rating, price: movie.price)),
      ).toList(),
      options: CarouselOptions(
        height: h * 0.55,
        enlargeCenterPage: true,
        autoPlay: false,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.75,
      ),
    );
  }
}
