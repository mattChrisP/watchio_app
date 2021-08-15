import 'package:flutter/material.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("body desu"),
      ),
      bottomNavigationBar: BottomNavBar(current: "explore"),
    );
  }
}
