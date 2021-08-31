import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/screens/explore_screen.dart';
import 'package:watchlist_app/widgets/display_card.dart';
import 'package:watchlist_app/widgets/loading.dart';

class DisplayWatchlist extends StatefulWidget {
  final userInfo;
  final bool view;

  const DisplayWatchlist({Key key, this.userInfo, @required this.view})
      : super(key: key);

  @override
  _DisplayWatchlistState createState() => _DisplayWatchlistState();
}

class _DisplayWatchlistState extends State<DisplayWatchlist> {
  List<dynamic> info = [];
  List<dynamic> images = [];
  bool infoExist = false;

  void getAnimeInfo() async {
    dynamic data = await FirebaseFirestore.instance
        .collection("animes")
        .where("uid", isEqualTo: widget.userInfo["uid"])
        .get();
    print(data.docs[0].data());
    print("above is data");
    for (var i = 0; i < data.docs.length; i++) {
      this.info.add(data.docs[i].data());
      this.infoExist = data.docs[i].exists;

      List image = [];
      dynamic imageData = await FirebaseFirestore.instance
          .collection("animes")
          .doc(data.docs[i].data()["animeId"])
          .collection("images")
          .orderBy("order", descending: false)
          .get();
      for (var i = 0; i < imageData.docs.length; i++) {
        image.add(imageData.docs[i].data());
      }
      this.images.add(image);
    }
    this.setState(() {});
  }

  @override
  void initState() {
    this.getAnimeInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((this.info.isEmpty || this.images.isEmpty) & this.infoExist) {
      return Loading();
    }
    print("below is info");
    print(this.info);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.5), BlendMode.dstATop),
                image: CachedNetworkImageProvider(
                    widget.userInfo["userProfilePicture"]),
              )),
            ),
            CustomPaint(
              child: Container(
                width: size.width,
                height: size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Positioned(
              top: config.kDefaultPadding * 2,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              ExploreScreen(),
                          transitionDuration: Duration(seconds: 0)));
                },
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: config.kDefaultPadding * 3),
                    child: Text(
                      "Watchlist",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        fontFamily: "MackinacBook",
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(config.kDefaultPadding),
                    width: size.width / 2,
                    height: size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        // image: CachedNetworkImageProvider(downloadUrl),
                        image: CachedNetworkImageProvider(
                            widget.userInfo["userProfilePicture"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: config.kDefaultPadding * 7 + size.width / 2,
              child: Padding(
                padding: EdgeInsets.only(left: config.kDefaultPadding * 2),
                child: InkWell(
                  child: Container(
                    width: size.width * 0.8,
                    child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: this.info.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, int index) => DisplayCard(
                              view: widget.view,
                              animeImage: this.images[index],
                              animeInfo: this.info[index],
                            )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
