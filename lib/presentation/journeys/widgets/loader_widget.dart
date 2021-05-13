import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sell_streams/utils/constants.dart';

class AppLoader extends StatelessWidget {

  final String text;
  AppLoader({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitFadingFour(size: 50.0, color: Colors.blue,),
          SizedBox(height: 10.0,),
          Text(text, style: kLoadingTextStyle, textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}