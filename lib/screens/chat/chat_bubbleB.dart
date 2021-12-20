import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';

class ChatBubbleB extends StatelessWidget {
  final String image;
  final String message;
  final int unread;

  const ChatBubbleB({Key key, this.message, this.unread, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: config.kDefaultPadding, bottom: config.kDefaultPadding),
      child: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: config.kDefaultPadding / 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: size.width - size.width / 1.4 - config.kDefaultPadding,
                ),
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
