import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/display_watchlist.dart';

class DisplayPeople extends StatelessWidget {
  final dynamic userInfo;

  const DisplayPeople({Key key, this.userInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    DisplayWatchlist(
                      view: true,
                      userInfo: userInfo,
                    ),
                transitionDuration: Duration(seconds: 0)),
            (Route<dynamic> route) => false);
      },
      child: Column(
        children: [
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.only(left: config.kDefaultPadding),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(config.kDefaultPadding),
                  width: size.width / 5,
                  height: size.width / 5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 5),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          userInfo["userProfilePicture"]),
                    ),
                  ),
                ),
                SizedBox(
                  width: config.kDefaultPadding,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userInfo["username"],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 1.2,
                        fontFamily: 'MackinacBook',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
