import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/screens/add_watclist_screen.dart';

import 'package:watchlist_app/screens/login_page.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';
import 'package:watchlist_app/widgets/display_card.dart';
import 'package:watchlist_app/widgets/loading.dart';

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
  List<dynamic> info = [];
  List<dynamic> favAnime = [];
  List<dynamic> images = [];
  List<dynamic> favAnimeImage = [];

  Future getAnimeInfo() async {
    dynamic data = await FirebaseFirestore.instance
        .collection("animes")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    for (var i = 0; i < data.docs.length; i++) {
      this.info.add(data.docs[i].data());

      dynamic imageData = await FirebaseFirestore.instance
          .collection("animes")
          .doc(data.docs[i].data()["animeId"])
          .collection("images")
          .orderBy("order", descending: false)
          .get();
      if (data.docs[i].data()["favourite"] == true) {
        this.favAnime.add(data.docs[i].data());
        List favImage = [];
        for (var i = 0; i < imageData.docs.length; i++) {
          favImage.add(imageData.docs[i].data());
        }
        this.favAnimeImage.add(favImage);
      }

      List image = [];

      for (var i = 0; i < imageData.docs.length; i++) {
        image.add(imageData.docs[i].data());
      }
      this.images.add(image);
    }
    return {
      "info": this.info,
      "favAnime": this.favAnime,
      "images": this.images,
      "favAnimeImage": this.favAnimeImage,
    };
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: this.getAnimeInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
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
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
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
                                  left: size.width / 4 -
                                      config.kDefaultPadding * 2.5),
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
                        padding: EdgeInsets.only(
                            left: 32.0,
                            right: 32,
                            top: 40,
                            bottom: config.kDefaultPadding / 2),
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
                      SingleChildScrollView(
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 200,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: config.kDefaultPadding * 2),
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(8),
                                    itemCount: this.info.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return DisplayCard(
                                        view: false,
                                        animeInfo: this.info[index],
                                        animeImage: this.images[index],
                                      );
                                    }),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              AddWatchlistScreen(
                                                edit: false,
                                              ),
                                          transitionDuration:
                                              Duration(seconds: 0)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: config.kDefaultPadding,
                                      right: config.kDefaultPadding),
                                  child: Container(
                                    width: 125,
                                    height: 168,
                                    padding:
                                        EdgeInsets.all(config.kDefaultPadding),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      border: Border.all(
                                          color: Colors.white, width: 5),
                                      color: config.lightSilverBlue,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                        ),
                                        Text(
                                          "Add",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily: 'MackinacBook',
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Text(
                                          "Watchlist",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily: 'MackinacBook',
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   width: size.width,
                      //   height: 200,
                      //   child: Center(
                      //     child: Text("You do not have any watchlist currently"),
                      //   ),
                      // ),
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
                      this.favAnime.isEmpty == true
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: config.kDefaultPadding * 3,
                                  top: config.kDefaultPadding / 2,
                                  bottom: config.kDefaultPadding,
                                  right: config.kDefaultPadding),
                              child: Container(
                                width: 125,
                                height: 168,
                                padding: EdgeInsets.all(config.kDefaultPadding),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  border:
                                      Border.all(color: Colors.white, width: 5),
                                  color: config.lightSilverBlue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "You do not",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily: 'MackinacBook',
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Text(
                                      "have any",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily: 'MackinacBook',
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Text(
                                      "favourite",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily: 'MackinacBook',
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Text(
                                      "currently",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily: 'MackinacBook',
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                height: 200,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: config.kDefaultPadding * 2),
                                      child: ListView.builder(
                                          physics: ScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(8),
                                          itemCount: this.favAnime.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return DisplayCard(
                                              view: false,
                                              animeInfo: this.favAnime[index],
                                              animeImage:
                                                  this.favAnimeImage[index],
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  dynamic details = "";
  bool infoExists = false;
  Future getInitialProfile() async {
    dynamic data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    print(data.data());
    print("below is bool above is data");
    this.infoExists = data.exists;
    if (data.exists) {
      this.details = data.data();
      return this.details;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: this.getInitialProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                            image: snapshot.data != false
                                ? CachedNetworkImageProvider(
                                    this.details["userProfilePicture"])
                                : AssetImage('assets/images/kimetsu_movie.png'),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      snapshot.data != false
                          ? this.details["username"]
                          : "Username",
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
                ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'MackinacBook',
                      letterSpacing: 1.2,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
