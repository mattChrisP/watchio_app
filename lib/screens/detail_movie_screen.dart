import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';

class DetailMovie extends StatefulWidget {
  static const routeName = "/detail_movie";
  static const IconData heart = IconData(0xf442,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  var fav = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: config.darkPurple,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height / 2,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/kimetsu_movie.png"),
                fit: BoxFit.cover,
              )),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      config.darkPurple,
                      config.darkPurple.withOpacity(0.8),
                      config.darkPurple.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home_page',
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                IconButton(
                  // icon: Icon(
                  //   DetailMovie.heart,
                  //   color: fav ? Colors.white : Colors.red,
                  // ),
                  icon: Icon(
                    Icons.favorite,
                    size: 25,
                    color: fav ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (fav == true) {
                      this.setState(() {
                        fav = false;
                      });
                    }
                    if (fav == false) {
                      this.setState(() {
                        fav = true;
                      });
                    }
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: config.kDefaultPadding / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Movie Title",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: config.kDefaultPadding / 2,
                  ),
                  Text(
                    "time epi genre can add year also",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.2,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: config.kDefaultPadding,
                  ),
                  Text(
                    "Synopsis",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: config.kDefaultPadding / 2,
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.2,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "bla bla bla ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white.withOpacity(0.7),
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
