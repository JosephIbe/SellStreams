import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_streams/presentation/blocs/authentication/auth.dart';
import 'package:sell_streams/utils/constants.dart';
import 'package:sell_streams/utils/strings.dart';
import 'package:wiredash/wiredash.dart';

double height, width;

class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          print('auth state building:\t $state');
          return ProfileOverViewPage();
        },
      ),
    );
  }
}

class ProfileOverViewPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: height * 0.2,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              width: width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0, 0.5, 0.75],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF24cdd8),
                        Color(0xFF24a4ef), Color(0xFF24cdd8),],
                      tileMode: TileMode.clamp)),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    bottom: -50.0,
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Container(
                        width: width * 0.85,
                        height: 80.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Favorites', style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                        fontSize: 20.0
                                    )
                                ),),
                                Text('0', style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15.0
                                    )
                                ),)
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              child: VerticalDivider(width: 1.5, color: Colors.orangeAccent, thickness: 3.0,),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Purchased', style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                        fontSize: 20.0
                                    )
                                ),),
                                Text('0', style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 15.0
                                    )
                                ),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30.0,
                    child: Text('My Account', style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 22.0
                        )
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.1,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildItemContainer(
                    title: 'Purchase History',
                    icon: Icons.policy_outlined,
                    onTapped: ()=> Navigator.pushNamed(context, purchaseHistoryRoute)
                ),
                buildItemContainer(
                    title: 'Privacy Policy',
                    icon: Icons.policy_outlined,
                    onTapped: ()=> Navigator.pushNamed(context, policyRoute)
                ),
                buildItemContainer(
                    title: 'Feedback',
                    icon: Icons.feedback_outlined,
                    onTapped: ()=> Wiredash.of(context).show()
                ),
                SizedBox(height: 40.0,),
                RaisedButton(
                  onPressed: () async {
                    authBloc.add(UserLoggedOut());
                    await Navigator.pushNamedAndRemoveUntil(context, loginRoute, (Route<dynamic> route) => false);
                  },
                  elevation: 2.0,
                  padding: EdgeInsets.symmetric(horizontal: 115.0, vertical: 15.0),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: Text('Sign Out', style: kCTAButtonTextStyle.copyWith(color: Colors.white),),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.pushNamed(context, profileDetailsRoute, ),
        child: Icon(Icons.edit, color: Colors.white,),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget buildItemContainer({IconData icon, String title, Function onTapped}){
    return GestureDetector(
        onTap: onTapped,
        child: Container(
            width: width,
            height: 55.0,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: Colors.orangeAccent.shade100,
                borderRadius: BorderRadius.all(Radius.circular(35.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(icon, color: Colors.indigoAccent,),
                            SizedBox(width: 25.0),
                            Text(title, textAlign: TextAlign.center, style: kProfileActionItemTextStyle,)
                          ],
                        ),
                        SizedBox(height: 10.0),
                      ],
                    )
                ),
              ],
            )
        )
    );
  }

}