import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_streams/data/models/genres_model.dart';
import 'package:sell_streams/presentation/blocs/genres/genres.dart';
import 'package:sell_streams/presentation/journeys/widgets/genre_item_card.dart';
import 'package:sell_streams/presentation/journeys/widgets/loader_widget.dart';

class GenresView extends StatefulWidget {
  @override
  _GenresViewState createState() => _GenresViewState();
}

class _GenresViewState extends State<GenresView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: BlocBuilder<GenresBloc, GenresState>(
            builder: (context, state){
              if(state is GenresStateFailure){
                return Center(
                  child: Text(state.errorMessage),
                );
              }

              if(state is GenresStateItemsLoadSuccess){
                return GenresList(allGenres: state.allGenres);
              }

              return AppLoader(text: 'Fetching Genres');
            }
          )
        ),
      ),
    );
  }
}

class GenresList extends StatelessWidget {

  final List<GenresModel> allGenres;
  GenresList({@required this.allGenres});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: allGenres.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              GenreItemCard(title: allGenres[index].title),
              SizedBox(height: 10.0,),
            ],
          );
        }
    );
  }
}
