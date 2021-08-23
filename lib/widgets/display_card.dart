import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/screens/detail_movie_screen.dart';
import 'package:watchlist_app/screens/home_screen.dart';

class DisplayCard extends StatelessWidget {
  final dynamic animeInfo;
  final dynamic animeImage;

  const DisplayCard({Key key, this.animeInfo, this.animeImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('below is anime imahe');
    print(animeImage);
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        DetailMovie(
                          animeInfo: animeInfo,
                          animeImage: animeImage,
                        ),
                    transitionDuration: Duration(seconds: 0)),
                (Route<dynamic> route) => false);
          },
          child: Container(
            height: 170,
            width: 125,
            margin: EdgeInsets.only(
                bottom: config.kDefaultPadding / 4,
                right: config.kDefaultPadding / 2,
                left: config.kDefaultPadding / 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  // image: AssetImage("assets/images/kimetsu_movie.png"),
                  image: CachedNetworkImageProvider(animeImage[0]["image_url"]),
                )),
          ),
        ),
      ],
    );
  }
}
