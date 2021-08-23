import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/screens/home_screen.dart';

class DetailMovie extends StatefulWidget {
  static const routeName = "/detail_movie";
  final dynamic animeInfo;
  final dynamic animeImage;

  const DetailMovie({Key key, this.animeInfo, this.animeImage})
      : super(key: key);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  var fav = false;

  @override
  void initState() {
    this.fav = widget.animeInfo["favourite"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("below is info");

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
            Padding(
              padding: EdgeInsets.only(top: config.kDefaultPadding / 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("animes")
                          .doc(widget.animeInfo["animeId"])
                          .update({
                        "favourite": this.fav,
                      });
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home_page',
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: 25,
                      color: this.fav ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      if (this.fav == true) {
                        this.setState(() {
                          this.fav = false;
                        });
                      } else {
                        this.setState(() {
                          this.fav = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: config.kDefaultPadding / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.animeInfo["movieTitle"],
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: config.kDefaultPadding / 4,
                  ),
                  Text(
                    widget.animeInfo["movieGenre"],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.2,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: config.kDefaultPadding * 2,
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
                    widget.animeInfo["movieSynopsis"],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.2,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: config.kDefaultPadding * 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Status: ",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          fontFamily: "MackinacBook",
                          letterSpacing: 1.5,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.animeInfo["status"],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "MackinacBook",
                          letterSpacing: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
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
