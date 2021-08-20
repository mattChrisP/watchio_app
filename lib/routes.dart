import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/screens/detail_movie_screen.dart';
import 'package:watchlist_app/screens/edit_watchlist.dart';
import 'package:watchlist_app/screens/home_screen.dart';
import 'package:watchlist_app/screens/info_page_screen.dart';
import 'package:watchlist_app/screens/login_page.dart';
import 'package:watchlist_app/screens/add_watclist_screen.dart';

final Map<String, WidgetBuilder> routes = {
  InfoPageScreen.routeName: (context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage();
    } else {
      return InfoPageScreen();
    }
  },
  LoginPage.routeName: (context) => LoginPage(),
  HomePage.routeName: (context) => HomePage(),
  AddWatchlistScreen.routeName: (context) => AddWatchlistScreen(),
  EditWatchlist.routeName: (context) => EditWatchlist(),
  DetailMovie.routeName: (context) => DetailMovie(),
};
