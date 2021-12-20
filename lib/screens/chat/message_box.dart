import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:watchlist_app/config.dart';

class MessageBox extends StatefulWidget {
  final String roomId;

  const MessageBox({Key key, this.roomId}) : super(key: key);

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  FirebaseMessaging messaging;
  TextEditingController messageContentController = TextEditingController();

  @override
  void initState() {
    print("below is value");
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: size.width,
        height: 110,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: size.width,
              height: 83,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: messageContentController,
                keyboardType: TextInputType.multiline,
                minLines: 1, //Normal textInputField will be displayed
                maxLines: null, // when user presses enter it will adapt to it
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write a Message",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.42),
                    fontSize: 12,
                    fontFamily: "MackinacBook",
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: config.kDefaultPadding / 3),
                Material(
                  type: MaterialType.transparency,
                  color: Colors.blue,
                  child: InkWell(
                    onTap: () async {
                      FirebaseFirestore.instance
                          .collection("chatrooms")
                          .doc(widget.roomId)
                          .collection("chats")
                          .doc(Uuid().v4())
                          .set({
                        "chat": messageContentController.text,
                        "sender": FirebaseAuth.instance.currentUser.uid,
                      });
                      messageContentController.text = "";
                    },
                    splashColor: Colors.grey,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: config.mediumPurple,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2.0),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "MackinacBook",
                            fontSize: 13,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: config.kDefaultPadding / 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
