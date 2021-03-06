import 'package:flutter/material.dart';
import 'package:sell_streams/utils/constants.dart';

class TopBanner extends StatelessWidget {

  final double height;
  final String title;
  final bool hasBackButton;
  final Function onBackPressed;

  TopBanner({this.height ,this.title, this.hasBackButton, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: hasBackButton ? 5.0 : 10.0),
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [0, 0.5, 0.75],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF24cdd8),
                Color(0xFF24a4ef), Color(0xFF24cdd8),],
              tileMode: TileMode.clamp)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hasBackButton
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  onPressed: onBackPressed
               )
              : Container(height: 25.0,),
          SizedBox(height: 15.0,),
          Text(title, style: kBannerTextStyle,)
        ],
      ),
    ));
  }
}
