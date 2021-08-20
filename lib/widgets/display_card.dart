import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';

class DisplayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/detail_movie',
              (Route<dynamic> route) => false,
            );
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
                  image: AssetImage("assets/images/kimetsu_movie.png"),
                  // image: CachedNetworkImageProvider(
                  //                     "blablabla"),
                )),
          ),
        ),
      ],
    );
  }
}
