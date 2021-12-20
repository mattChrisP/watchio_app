import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/screens/chat/chat_bubbleA.dart';
import 'package:watchlist_app/screens/chat/chat_bubbleB.dart';
import 'package:watchlist_app/screens/chat/message_box.dart';
import 'package:watchlist_app/widgets/loading.dart';

class ChatScreen extends StatefulWidget {
  final userInfo;
  const ChatScreen({Key key, this.userInfo}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String newRoomId = Uuid().v4();
  String chatRoomId = '';

  Future getChatRoom() async {
    dynamic roomId = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("chatId", isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where("recipientId", isEqualTo: widget.userInfo["uid"])
        .get();

    if (roomId.docs.length > 0) {
      this.chatRoomId = roomId.docs[0].data()["roomId"];
    } else {
      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(this.newRoomId)
          .set({
        "chatId": FirebaseAuth.instance.currentUser.uid,
        "recipientId": widget.userInfo["uid"],
        "roomId": this.newRoomId,
      });
      this.chatRoomId = this.newRoomId;
    }
    return this.chatRoomId;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: config.mediumPurple,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            Container(
              padding: EdgeInsets.all(config.kDefaultPadding),
              width: size.width / 7,
              height: size.width / 7,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5),
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      widget.userInfo["userProfilePicture"]),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: config.kDefaultPadding),
                  child: Text(
                    widget.userInfo["username"],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "MackinacBook",
                      letterSpacing: 1.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.7 - config.kDefaultPadding,
              child: FutureBuilder(
                future: this.getChatRoom(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  } else {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("chatrooms")
                          .doc(this.chatRoomId)
                          .collection("chats")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var chats = snapshot.data.docs.map((chatsSnapshot) {
                            var data = chatsSnapshot.data();
                            return data;
                          }).toList();
                          var orderedChat = new List.from(chats.reversed);
                          print(chats[0]["chat"]);
                          print("this is data");
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: chats.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    chats[index]["sender"] ==
                                            FirebaseAuth
                                                .instance.currentUser.uid
                                        ? ChatBubbleB(
                                            message: orderedChat[index]["chat"],
                                          )
                                        // ? ChatBubbleA(
                                        //     message: chats[index]["chat"],
                                        //     image: widget
                                        //         .userInfo["userProfilePicture"],
                                        //   )
                                        : ChatBubbleA(
                                            message: orderedChat[index]["chat"],
                                            image: widget
                                                .userInfo["userProfilePicture"],
                                          ),
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  }
                },
              ),
            ),
            MessageBox(
              roomId: this.chatRoomId,
            ),
          ],
        ),
      ),
    );
  }
}
