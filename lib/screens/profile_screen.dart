import 'package:flutter/material.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("this is profile desu"),
      ),
      bottomNavigationBar: BottomNavBar(
        current: "profile",
      ),
    );
  }
}
