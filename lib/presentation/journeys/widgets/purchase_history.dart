import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseHistory extends StatelessWidget {

  double width, height;

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: ()=> Navigator.pop(context),
                  icon: Icon(Icons.chevron_left, color: Colors.purple, size: 35.0,),
                ),
                title: Text('My Orders', style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    )
                )),
                backgroundColor: Colors.white,
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => PurchaseHistoryItem(
                      title: 'Black Panther',
                      imageURL: 'https://upload.wikimedia.org/wikipedia/en/9/9f/Black_Panther_OS_Vol_1_2.png',
                      price: 49.50
                  ),
                  childCount: 10
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget PurchaseHistoryItem({String title, double price, String imageURL}){
    return Column(
      children: [
        Container(
          width:  width ,
          height: height * 0.30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
              colors: [
                // Color(0xFF252443),
                Color(0xFF4d4bb8),
                Color(0xFF252443),
              ],
              stops: [0.6, 1.0],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle
                    ),
                    child: Image.network(imageURL, fit: BoxFit.contain,),
                  ),
                  SizedBox(width: 10.0,),
                  Text(title),
                ],
              ),
              Divider(color: Colors.white70, thickness: 1.5,),
              Text('Genres:'),
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
              Text('Payment Mode: Card'),
              Text('Date: 06/05/2021'),
              Text('Total Amount: \$$price'),
            ],
          ),
        ),
        SizedBox(height: 10.0,)
      ],
    );
  }

}