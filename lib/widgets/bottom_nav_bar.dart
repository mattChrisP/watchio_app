import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/screens/edit_watchlist.dart';
import 'package:watchlist_app/screens/explore_screen.dart';
import 'package:watchlist_app/screens/home_screen.dart';
import 'package:watchlist_app/screens/profile_screen.dart';
import 'package:watchlist_app/screens/add_watclist_screen.dart';
import 'package:watchlist_app/widgets/custom_alert_dialog.dart';

class BottomNavBar extends StatefulWidget {
  final String userInfo;
  final String current;
  const BottomNavBar({
    Key key,
    @required this.current,
    this.userInfo,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String details = "";
  bool check = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int index = 0;
  void getInitialProfile() async {
    dynamic data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    print(data.data());
    print("below is bool above is data");
    this.check = true;
    if (data.exists) {
      this.details = data.data()["username"];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.check == false) {
      this.getInitialProfile();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(40),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 10),
          //     blurRadius: 33,
          //     color: Colors.black.withOpacity(0.5),
          //   )
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipOval(
                    child: Material(
                      type: MaterialType.transparency,
                      color: Colors.blue, // button color
                      child: InkWell(
                        splashColor: Colors.grey, // inkwell color
                        child: SizedBox(
                          width: 66,
                          height: 56,
                          child: Column(
                            children: [
                              Icon(
                                Icons.home,
                                size: 30,
                                color: widget.current == "home"
                                    ? Colors.black
                                    : Colors.grey.withOpacity(0.52),
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    fontFamily: "MackinacBook", fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          HomePage(),
                                  transitionDuration: Duration(seconds: 0)));
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 66,
                    height: 56,
                    child: Material(
                      type: MaterialType.transparency,
                      color: Colors.blue,
                      child: InkWell(
                        splashColor: Colors.grey,
                        child: Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 1,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 30,
                                    color: widget.current == "watchlist"
                                        ? Colors.black
                                        : Colors.grey.withOpacity(0.52),
                                  ),
                                  Text(
                                    "Watchlist",
                                    style: TextStyle(
                                        fontFamily: "MackinacBook",
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          EditWatchlist(),
                                  transitionDuration: Duration(seconds: 0)));
                        },
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      type: MaterialType.transparency,
                      color: Colors.blue, // button color
                      child: InkWell(
                        splashColor: Colors.grey, // inkwell color
                        child: SizedBox(
                          width: 66,
                          height: 56,
                          child: Column(
                            children: [
                              Icon(
                                Icons.person,
                                size: 30,
                                color: widget.current == "profile"
                                    ? Colors.black
                                    : Colors.grey.withOpacity(0.52),
                              ),
                              Text(
                                " Edit Profile",
                                style: TextStyle(
                                    fontFamily: "MackinacBook", fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          ProfileScreen(),
                                  transitionDuration: Duration(seconds: 0)));
                        },
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      type: MaterialType.transparency,
                      color: Colors.blue, // button color
                      child: InkWell(
                        splashColor: Colors.grey, // inkwell color
                        child: SizedBox(
                          width: 66,
                          height: 56,
                          child: Column(
                            children: [
                              Icon(
                                Icons.people,
                                size: 30,
                                color: widget.current == "explore"
                                    ? Colors.black
                                    : Colors.grey.withOpacity(0.52),
                              ),
                              Text(
                                "Explore",
                                style: TextStyle(
                                    fontFamily: "MackinacBook", fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (this.details != "") {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            ExploreScreen(),
                                    transitionDuration: Duration(seconds: 0)));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                      alertText:
                                          "You need to create a username before continuing!",
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    ProfileScreen(),
                                                transitionDuration:
                                                    Duration(seconds: 0)));
                                      },
                                    ));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
