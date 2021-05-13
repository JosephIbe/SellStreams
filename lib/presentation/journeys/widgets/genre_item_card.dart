import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sell_streams/utils/constants.dart';

class GenreItemCard extends StatelessWidget {

  final String title;
  GenreItemCard({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Center(
        child: Text(title, style: kGenreTitleTextStyle, textAlign: TextAlign.center,),
      ),
    );
  }
}
