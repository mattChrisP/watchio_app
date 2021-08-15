import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/routes.dart';
import 'package:watchlist_app/screens/info_page_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: InfoPageScreen.routeName,
      routes: routes,
    );
  }
}
