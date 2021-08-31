import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/screens/explore_screen.dart';
import 'package:watchlist_app/screens/home_screen.dart';
import 'package:watchlist_app/widgets/display_images_slider.dart';

class DetailMovie extends StatefulWidget {
  static const routeName = "/detail_movie";
  final dynamic animeInfo;
  final dynamic animeImage;
  final bool view;

  const DetailMovie(
      {Key key, this.animeInfo, this.animeImage, @required this.view})
      : super(key: key);

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  var fav = false;
  bool addWatchlist = false;

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
        child: Stack(
          children: [
            Positioned(
              top: size.width * 1.43,
              child: Container(
                width: size.width,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: config.kDefaultPadding / 1.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: !widget.view
                                  ? () async {
                                      await FirebaseFirestore.instance
                                          .collection("animes")
                                          .doc(widget.animeInfo["animeId"])
                                          .update({
                                        "favourite": this.fav,
                                      });
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        '/home_page',
                                        (Route<dynamic> route) => false,
                                      );
                                    }
                                  : () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  ExploreScreen(),
                                              transitionDuration:
                                                  Duration(seconds: 0)));
                                      // Navigator.pop(context);
                                    }),
                          !widget.view
                              ? IconButton(
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
                                )
                              : IconButton(
                                  icon: Icon(
                                    this.addWatchlist
                                        ? Icons.bookmark_added_rounded
                                        : Icons.bookmark_add_outlined,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (this.addWatchlist == true) {
                                      this.setState(() {
                                        this.addWatchlist = false;
                                      });
                                    } else {
                                      this.setState(() {
                                        this.addWatchlist = true;
                                      });
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: config.kDefaultPadding / 2),
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
            ),
            Container(
              height: size.width,
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
            Container(
              height: size.height * 2,
              width: size.width,
              child: Column(
                children: [
                  DisplayImagesSlider(
                    animeImage: widget.animeImage,
                  ),
                ],
              ),
            ),
            Container(
              height: size.width * 1.43,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    config.darkPurple,
                    config.darkPurple.withOpacity(0.9),
                    // config.darkPurple.withOpacity(0.8),
                    // config.darkPurple.withOpacity(0.7),
                    // config.darkPurple.withOpacity(0.6),
                    config.darkPurple.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
