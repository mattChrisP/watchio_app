import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/add_image.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';
import 'package:watchlist_app/widgets/buttons.dart';

class AddWatchlistScreen extends StatefulWidget {
  static const routeName = "/add_watchlist";
  @override
  _AddWatchlistScreenState createState() => _AddWatchlistScreenState();
}

class _AddWatchlistScreenState extends State<AddWatchlistScreen> {
  var currentUser = FirebaseAuth.instance.currentUser.uid;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController genresController = TextEditingController();
  final TextEditingController synopsisController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String animeId = Uuid().v4();
  File imageFile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: config.mediumPurple,
      appBar: AppBar(
        backgroundColor: config.mediumPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/edit_watchlist',
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Container(
                height: size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: this._formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Image",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'MackinacBook',
                            ),
                          ),
                          Text(
                            "The first image you put will be the main image",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: 'MackinacBook',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    AnimeImagesEdit(
                      animeId: animeId,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'MackinacBook',
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 8),
                                height: 30,
                                width: size.width - config.kDefaultPadding * 2,
                                decoration: BoxDecoration(
                                  color: config.lightOrange.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[a-zA-Z0-9 &()\"+\$?.:]"))
                                  ],
                                  controller: titleController,
                                  onChanged: (value) => {},
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration.collapsed(
                                    border: InputBorder.none,
                                    hintText: "Demon Slayer",
                                    hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.42),
                                      fontSize: 12,
                                      fontFamily: "MackinacBook",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Genres",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'MackinacBook',
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 8),
                                height: 30,
                                width: size.width - config.kDefaultPadding * 2,
                                decoration: BoxDecoration(
                                  color: config.lightOrange.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextField(
                                  controller: genresController,
                                  onChanged: (value) => {},
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration.collapsed(
                                    border: InputBorder.none,
                                    hintText: "Action, Adventure, Comedy",
                                    hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.42),
                                      fontSize: 12,
                                      fontFamily: "MackinacBook",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Synposis",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'MackinacBook',
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8),
                            height: 84,
                            width: size.width - config.kDefaultPadding * 2,
                            decoration: BoxDecoration(
                              color: config.lightOrange.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    controller: synopsisController,
                                    onChanged: (value) => {},
                                    decoration: InputDecoration.collapsed(
                                      border: InputBorder.none,
                                      hintText:
                                          "Synopsis, as long as you want !!",
                                      hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.42),
                                        fontSize: 12,
                                        fontFamily: "MackinacBook",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: config.kDefaultPadding * 3,
                    ),
                    Container(
                        child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FunctionButton(
                            onTap: () async {
                              if (this._formKey.currentState.validate()) {
                                String id = Uuid().v4();
                                // final imageRef = FirebaseStorage.instance
                                //     .ref()
                                //     .child("images/${id}/main_image");
                                // await imageRef.putFile(this.imageFile);
                                // String imageUrl =
                                //     await imageRef.getDownloadURL();
                                FirebaseFirestore.instance
                                    .collection("animes")
                                    .doc(animeId)
                                    .set({
                                  "uid": currentUser,
                                  "movieTitle": titleController.text,
                                  "movieGenre": genresController.text,
                                  "movieSynopsis": synopsisController.text,
                                  "favourite": false,
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            width: size.width * 0.7,
                            text: "Save",
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
