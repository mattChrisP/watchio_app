import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:watchlist_app/widgets/add_image.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';

class AddWatchlistScreen extends StatefulWidget {
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
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
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
                  child: Text(
                    "Image",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'MackinacBook',
                    ),
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
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
                          ],
                        ),
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z0-9 &()\"+\$?.:]"))
                              ],
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
                          ],
                        ),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z0-9 &()\"+\$?.:]"))
                                ],
                                controller: synopsisController,
                                onChanged: (value) => {},
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration.collapsed(
                                  border: InputBorder.none,
                                  hintText: "Synopsis, as long as you want !!",
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
                Container(
                    child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        // color: Color(0XFF307777),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.lightBlue),
                        onPressed: () async {
                          if (this._formKey.currentState.validate()) {
                            String id = Uuid().v4();
                            final imageRef = FirebaseStorage.instance
                                .ref()
                                .child("images/${id}/main_image");
                            await imageRef.putFile(this.imageFile);
                            String imageUrl = await imageRef.getDownloadURL();
                            FirebaseFirestore.instance
                                .collection("items")
                                .doc(id)
                                .set({
                              "uid": currentUser,
                              "itemImage": imageUrl,
                              "itemBrand": titleController.text,
                              "price": genresController.text,
                              "quantity": synopsisController.text,
                              "date": Timestamp.now(),
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Add as already watched",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
                Container(
                    child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        // color: Color(0XFF307777),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.lightBlue),
                        onPressed: () async {
                          if (this._formKey.currentState.validate()) {
                            String id = Uuid().v4();
                            final imageRef = FirebaseStorage.instance
                                .ref()
                                .child("images/${id}/main_image");
                            await imageRef.putFile(this.imageFile);
                            String imageUrl = await imageRef.getDownloadURL();
                            FirebaseFirestore.instance
                                .collection("items")
                                .doc(id)
                                .set({
                              "uid": currentUser,
                              "itemImage": imageUrl,
                              "itemBrand": titleController.text,
                              "price": genresController.text,
                              "quantity": synopsisController.text,
                              "date": Timestamp.now(),
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Add as currently watching",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
                Container(
                    child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        // color: Color(0XFF307777),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.lightBlue),
                        onPressed: () async {
                          if (this._formKey.currentState.validate()) {
                            String id = Uuid().v4();
                            final imageRef = FirebaseStorage.instance
                                .ref()
                                .child("images/${id}/main_image");
                            await imageRef.putFile(this.imageFile);
                            String imageUrl = await imageRef.getDownloadURL();
                            FirebaseFirestore.instance
                                .collection("items")
                                .doc(id)
                                .set({
                              "uid": currentUser,
                              "itemImage": imageUrl,
                              "itemBrand": titleController.text,
                              "price": genresController.text,
                              "quantity": synopsisController.text,
                              "date": Timestamp.now(),
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          "Add as to watch",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(current: "watchlist"),
    );
  }
}
