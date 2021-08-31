import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/screens/detail_movie_screen.dart';
import 'package:watchlist_app/screens/edit_watchlist.dart';
import 'package:watchlist_app/screens/home_screen.dart';

import 'package:watchlist_app/screens/login_page.dart';

final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage();
    } else {
      return LoginPage();
    }
  },
  HomePage.routeName: (context) => HomePage(),
  EditWatchlist.routeName: (context) => EditWatchlist(),
};
