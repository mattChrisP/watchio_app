import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/screens/add_watclist_screen.dart';

class EditableCard extends StatefulWidget {
  final dynamic animeInfo;
  final dynamic animeImage;

  const EditableCard({Key key, @required this.animeInfo, this.animeImage})
      : super(key: key);

  @override
  _EditableCardState createState() => _EditableCardState();
}

class _EditableCardState extends State<EditableCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 170,
              width: 140,
              margin: EdgeInsets.only(
                  bottom: config.kDefaultPadding / 4,
                  right: config.kDefaultPadding / 2,
                  left: config.kDefaultPadding / 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    // image: AssetImage("assets/images/kimetsu_movie.png"),
                    image: CachedNetworkImageProvider(
                        widget.animeImage[0]["image_url"]),
                  )),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: config.kDefaultPadding),
            //   child: Container(
            //     width: 140,
            //     child: Text(
            //       widget.animeInfo["movieTitle"],
            //       style: TextStyle(
            //         fontFamily: "MackinacBook",
            //         fontSize: 15,
            //         fontWeight: FontWeight.w600,
            //         letterSpacing: 1.2,
            //       ),
            //       maxLines: 1,
            //       overflow: TextOverflow.clip,
            //     ),
            //   ),
            // )
          ],
        ),
        Positioned(
          top: 5,
          left: 100,
          child: CircleAvatar(
            radius: 17,
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: Icon(
                Icons.edit,
                size: 17,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            AddWatchlistScreen(
                              edit: true,
                              animeInfo: widget.animeInfo,
                              animeImage: widget.animeImage,
                            ),
                        transitionDuration: Duration(seconds: 0)));
              },
            ),
          ),
        ),
      ],
    );
  }
}
