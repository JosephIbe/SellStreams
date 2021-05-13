import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_streams/utils/constants.dart';

class MovieItemCard extends StatelessWidget {
  final String title;
  final String imgURL;
  final String rating;
  final String price;

  MovieItemCard({
    @required this.title,
    @required this.imgURL,
    @required this.rating,
    @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imgURL,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kMovieTitleTextStyle,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 60.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                rating,
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                        color: Colors.orange, fontSize: 12.0)),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                    ),
                    Container(
                        width: 100.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        child: Center(
                          child: Text(
                            '\$$price',
                            style: kMoviePriceTextStyle,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
