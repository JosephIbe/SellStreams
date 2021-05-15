import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sell_streams/data/models/movie_model.dart';
import 'package:sell_streams/utils/constants.dart';
import 'package:sell_streams/utils/strings.dart';

import 'package:sell_streams/presentation/blocs/cart/cart.dart';

import 'package:better_player/better_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetails extends StatefulWidget {

  final Movies movie;
  MovieDetails({@required this.movie});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  double width, height;
  BetterPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.movie.videoURL ?? "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
      _playerController = BetterPlayerController(
        BetterPlayerConfiguration(
          fit: BoxFit.cover,
          showPlaceholderUntilPlay: true,
          placeholderOnTop: true,
          placeholder: Image.network(widget.movie.imageURL, fit: BoxFit.cover,),
          autoPlay: false,
          fullScreenByDefault: false,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableProgressText: true,
            showControlsOnInitialize: false,
            enableMute: true,
            enableFullscreen: true,
          ),
          deviceOrientationsOnFullScreen: [DeviceOrientation.landscapeLeft],
        ),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon: Icon(Icons.chevron_left, color: Colors.white,),
          ),
          automaticallyImplyLeading: false,
          title: Text('Movie Details', style: kAppNameTextStyle,),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColorDark,
          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.favorite_border, color: Colors.white,),
            )
          ],
        ),
        body: Container(
            width: width,
            height: height,
            color: Theme.of(context).primaryColorDark,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: width,
                          height:  height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                          ),
                          // child: Image.network(movie.imageURL ?? 'https://upload.wikimedia.org/wikipedia/en/9/9f/Black_Panther_OS_Vol_1_2.png', fit: BoxFit.cover,),
                          child: AspectRatio(
                            aspectRatio: 16/9,
                            child: BetterPlayer(
                              controller: _playerController,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.movie.title ?? 'Black Panther', style: kMovieTitleTextStyle, textAlign: TextAlign.start,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Director: ${widget.movie.director} ', style: kMovieDetailsSubHeadingTextStyle, ),
                              SizedBox(width: 10.0,),
                              Container(
                                height: 15.0,
                                margin: EdgeInsets.symmetric(vertical: 2.0),
                                child: VerticalDivider(width: 1.5, color: Colors.orangeAccent, thickness: 3.0,),
                              ),
                              SizedBox(width: 10.0,),
                              Row(
                                children: [
                                  Text(widget.movie.rating ?? '4.8', style: kMovieDetailsSubHeadingTextStyle, textAlign: TextAlign.start,),
                                  Icon(Icons.star, color: Colors.deepOrange,),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                label: Text('Drama'),
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                              SizedBox(width: 5.0,),
                              Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                label: Text('Action'),
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                              SizedBox(width: 5.0,),
                              Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                ),
                                label: Text('Adventure'),
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0,),
                          Text('Synopsis', style: kMovieTitleTextStyle, textAlign: TextAlign.start,),
                          SizedBox(height: 10.0,),
                          Text(widget.movie.synopsis ?? synopsisTxt, style: kMovieSynopsisTextStyle, textAlign: TextAlign.start,),
                          SizedBox(height: 30.0,),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30.0,
                  left: width * 0.25,
                  child: RaisedButton(
                    onPressed: (){
                      print(widget.movie.id);
                      BlocProvider.of<CartBloc>(context).add(AddToCartItems(movieId: widget.movie.id));
                    },
                    elevation: 2.0,
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Text('Buy This Movie', style: kCTAButtonTextStyle.copyWith(color: Colors.white),),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}