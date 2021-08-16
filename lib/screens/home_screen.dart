import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        current: "home",
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                config.bluenishPurple,
                config.mediumPurple,
                config.mediumPink
              ]),
          // color: Colors.grey[200],
          // image: DecorationImage(
          //   image: AssetImage("assets/images/kimi_no_nawa.png"),
          //   fit: BoxFit.cover,
          // ),
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.225,
              decoration: BoxDecoration(
                  color: config.mediumBlue.withOpacity(0.6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(36),
                  )),
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isDrawerOpen
                          ? IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                setState(() {
                                  xOffset = 230;
                                  yOffset = 150;
                                  scaleFactor = 0.6;
                                  isDrawerOpen = true;
                                });
                              }),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                size.width / 4 - config.kDefaultPadding * 2.5),
                        child: Column(
                          children: [
                            Text(
                              "Watchio",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
                                letterSpacing: 1.5,
                                fontFamily: 'MackinacBook',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 32.0),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: SvgPicture.asset("assets/icons/search.svg"),
                        hintText: "Search your watchlist",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.42),
                          fontFamily: "MackinacBook",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                        height: 35,
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: config.lightGreenishBlue,
                                    style: BorderStyle.solid,
                                    width: 3.0))),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Watchlist",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'MackinacBook',
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ))),
                Container(
                  width: size.width,
                  height: 200,
                  child: Center(
                    child: Text("You do not have any watchlist currently"),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Container(
                        height: 35,
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: config.lightGreenishBlue,
                                    style: BorderStyle.solid,
                                    width: 3.0))),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Favourites",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'MackinacBook',
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ))),
                Container(
                  width: size.width,
                  height: 200,
                  child: Center(
                    child: Text("You do not have any favourite currently"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [config.mediumBlue, config.bluenishPurple])),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    config.kDefaultPadding,
                    config.kDefaultPadding * 3,
                    config.kDefaultPadding,
                    config.kDefaultPadding),
                child: Container(
                  padding: EdgeInsets.all(config.kDefaultPadding),
                  width: size.width / 3,
                  height: size.width / 3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/kimetsu_movie.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Log out',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
