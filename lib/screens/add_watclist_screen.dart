import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:uuid/uuid.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/add_image.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';
import 'package:watchlist_app/widgets/buttons.dart';
import 'package:watchlist_app/widgets/custom_alert_dialog.dart';

class AddWatchlistScreen extends StatefulWidget {
  final bool edit;
  final dynamic animeInfo;
  final dynamic animeImage;
  static const routeName = "/add_watchlist";

  const AddWatchlistScreen(
      {Key key, @required this.edit, this.animeInfo, this.animeImage})
      : super(key: key);
  @override
  _AddWatchlistScreenState createState() => _AddWatchlistScreenState();
}

class _AddWatchlistScreenState extends State<AddWatchlistScreen> {
  var currentUser = FirebaseAuth.instance.currentUser.uid;
  StatusInputController statusController = StatusInputController();
  TextEditingController titleController = TextEditingController();
  TextEditingController genresController = TextEditingController();
  TextEditingController synopsisController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String animeId = Uuid().v4();
  File imageFile;

  @override
  void initState() {
    if (widget.edit == true) {
      statusController.choice = widget.animeInfo["status"];
      titleController =
          TextEditingController(text: widget.animeInfo["movieTitle"]);
      genresController =
          TextEditingController(text: widget.animeInfo["movieGenre"]);
      synopsisController =
          TextEditingController(text: widget.animeInfo["movieSynopsis"]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.edit == true) {
    //   statusController.choice = widget.animeInfo["status"];
    //   titleController =
    //       TextEditingController(text: widget.animeInfo["movieTitle"]);
    //   genresController =
    //       TextEditingController(text: widget.animeInfo["movieGenre"]);
    //   synopsisController =
    //       TextEditingController(text: widget.animeInfo["movieSynopsis"]);
    // }

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
            showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                      alertText:
                          "Your Listing has not been saved, are you sure you want to exit?",
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ));
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
                      animeId:
                          widget.edit ? widget.animeInfo["animeId"] : animeId,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'MackinacBook',
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: config.kDefaultPadding / 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StatusInput(
                                controller: statusController,
                                width: size.width,
                              ),
                            ],
                          ),
                        ],
                      ),
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
                              letterSpacing: 1.2,
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
                                  inputFormatters: [],
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
                                widget.edit
                                    ? FirebaseFirestore.instance
                                        .collection("animes")
                                        .doc(animeId)
                                        .update({
                                        "uid": currentUser,
                                        "movieTitle": titleController.text,
                                        "movieGenre": genresController.text,
                                        "movieSynopsis":
                                            synopsisController.text,
                                        "favourite": false,
                                        "status": statusController.choice,
                                        "animeId": animeId,
                                      })
                                    : FirebaseFirestore.instance
                                        .collection("animes")
                                        .doc(animeId)
                                        .set({
                                        "uid": currentUser,
                                        "movieTitle": titleController.text,
                                        "movieGenre": genresController.text,
                                        "movieSynopsis":
                                            synopsisController.text,
                                        "favourite": false,
                                        "status": statusController.choice,
                                        "animeId": animeId,
                                      });
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/edit_watchlist',
                                  (Route<dynamic> route) => false,
                                );
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

class StatusInputController {
  String choice;
}

class StatusInput extends StatefulWidget {
  final StatusInputController controller;
  final double width;

  const StatusInput({
    Key key,
    this.controller,
    this.width,
  }) : super(key: key);

  StatusInputState createState() => StatusInputState();
}

class StatusInputState extends State<StatusInput> {
  String selectedStatus;
  List StatusMenu = [
    "Already Watched",
    "Currently Watching",
    "Will Watch",
  ];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: config.kDefaultPadding / 2),
      width: widget.width,
      decoration: BoxDecoration(
        color: config.lightOrange.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: SizedBox(
          child: DropdownButton(
        hint: Text(
          "Status",
          style: TextStyle(
            color: Colors.black.withOpacity(0.42),
            fontSize: 12,
            fontFamily: "MackinacBook",
          ),
        ),
        dropdownColor: config.lightOrange,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        isExpanded: true,
        underline: SizedBox(),
        // style: TextStyle(
        //   color: Colors.black,
        //   fontSize: 12,
        //   fontFamily: "MackinacBook",
        // ),
        value: widget.controller.choice,
        onChanged: (newStatus) {
          this.setState(() {
            widget.controller.choice = newStatus;
          });
        },
        items: this.StatusMenu.map((statusMenu) {
          return DropdownMenuItem(
            value: statusMenu,
            child: Text(statusMenu),
          );
        }).toList(),
      )),
    );
  }
}
