import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';

class ChatBubbleA extends StatelessWidget {
  final String image;
  final String message;
  final int unread;

  const ChatBubbleA({Key key, this.message, this.unread, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(config.kDefaultPadding),
      child: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: config.kDefaultPadding / 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: CachedNetworkImageProvider(this.image),
                ),
                SizedBox(width: config.kDefaultPadding / 4),
                Container(
                  width: size.width / 1.4,
                  decoration: BoxDecoration(
                    color: config.lightSilverBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(config.kDefaultPadding),
                    child: Text(this.message),
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
