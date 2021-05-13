import 'package:flutter/material.dart';

import 'genres/index.dart';
import 'movies/index.dart';
import 'profile/index.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  var currentIndex = 0;
  var children = [
    HomeView(),
    GenresView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: children[currentIndex],
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: currentIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              currentIndex = index;
            }),
            items: [
              BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  activeColor: Theme.of(context).primaryColorDark,
                  inactiveColor: Colors.blueGrey
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.category_outlined),
                  title: Text('Genres'),
                  activeColor: Theme.of(context).primaryColorDark,
                  inactiveColor: Colors.blueGrey
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Account'),
                  activeColor: Theme.of(context).primaryColorDark,
                  inactiveColor: Colors.blueGrey
              ),
            ],
          ),
        )
    );
  }
}