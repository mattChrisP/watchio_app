import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';
import 'package:watchlist_app/widgets/buttons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController addBioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController favouriteQuoteController = TextEditingController();
  TextEditingController favouriteMovieSeriesController =
      TextEditingController();
  List<dynamic> details = [];

  void getInitialProfile() async {
    dynamic data = await FirebaseFirestore.instance.collection("users").get();

    for (var i = 0; i < data.docs.length; i++) {
      this.details.add(data.docs[i].data());
    }
    print(this.details);
    this.setState(() {});
  }

  @override
  void initState() {
    this.getInitialProfile();
    // addBioController = TextEditingController(text: "");
    // usernameController = TextEditingController(text: " ");
    // favouriteQuoteController = TextEditingController(text: " ");
    // favouriteMovieSeriesController = TextEditingController(text: " ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("this is details inside");
    print(this.details);
    Size size = MediaQuery.of(context).size;
    var downloadUrl = "";
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: [
            CustomPaint(
              child: Container(
                width: size.width,
                height: size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: config.kDefaultPadding * 3),
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        fontFamily: "MackinacBook",
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(config.kDefaultPadding),
                    width: size.width / 2,
                    height: size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/kimetsu_movie.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: config.kDefaultPadding * 4 + size.width / 4,
              left: size.width * 0.75 - 20,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    PickedFile image = await ImagePicker().getImage(
                        source: ImageSource.gallery, imageQuality: 100);
                    File croppedFile = await ImageCropper.cropImage(
                        sourcePath: image.path,
                        cropStyle: CropStyle.circle,
                        aspectRatioPresets: Platform.isAndroid
                            ? [
                                CropAspectRatioPreset.square,
                              ]
                            : [
                                CropAspectRatioPreset.square,
                              ],
                        androidUiSettings: AndroidUiSettings(
                            toolbarTitle: 'Crop Image',
                            toolbarColor: Colors.brown[800],
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        iosUiSettings: IOSUiSettings(
                          title: 'Crop Image',
                        ));
                    if (croppedFile != null) {
                      Directory tempDir = await getTemporaryDirectory();
                      File image =
                          await FlutterImageCompress.compressAndGetFile(
                        croppedFile.absolute.path,
                        "${tempDir.absolute.path}/image_${basename(croppedFile.path)}",
                        minWidth: 250,
                        minHeight: 250,
                        quality: 50,
                      );
                      final firebaseStorageRef = FirebaseStorage.instance
                          .ref()
                          .child(
                              'users/${FirebaseAuth.instance.currentUser.uid}');
                      await firebaseStorageRef.putFile(image);
                      downloadUrl = await firebaseStorageRef.getDownloadURL();
                    }
                  },
                ),
              ),
            ),
            Positioned(
              top: config.kDefaultPadding * 7 + size.width / 2,
              child: Padding(
                padding: EdgeInsets.only(left: config.kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "My Bio",
                        style: TextStyle(
                          fontFamily: "MackinacBook",
                          fontSize: 15,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: config.kDefaultPadding / 2),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                      height: 67,
                      width: size.width - config.kDefaultPadding * 2,
                      decoration: BoxDecoration(
                        color: config.lightOrange.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            // initialValue: this.details[0]["userBio"],
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            inputFormatters: [],
                            controller: addBioController,
                            onChanged: (value) => {},
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: "Short description about yourself",
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
                    SizedBox(height: config.kDefaultPadding * 1.4),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(
                              fontFamily: "MackinacBook",
                              fontSize: 15,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: config.kDefaultPadding / 2),
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
                                  RegExp("[a-zA-Z0-9 &()\"+\$?.:]")),
                            ],
                            textCapitalization: TextCapitalization.words,
                            controller: usernameController,
                            // onChanged: (value) {},
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: "Make a cool username",
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
                    SizedBox(height: config.kDefaultPadding * 1.4),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "My Favourite Quote",
                            style: TextStyle(
                              fontFamily: "MackinacBook",
                              fontSize: 15,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: config.kDefaultPadding / 2),
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
                                  RegExp("[a-zA-Z0-9 &()\"+\$?.:]")),
                            ],
                            textCapitalization: TextCapitalization.words,
                            controller: favouriteQuoteController,
                            // onChanged: (value) {},
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: "Good quote",
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
                    SizedBox(height: config.kDefaultPadding * 1.4),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "My Best Watched Movie or Series",
                            style: TextStyle(
                              fontFamily: "MackinacBook",
                              fontSize: 15,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: config.kDefaultPadding / 2),
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
                                  RegExp("[a-zA-Z0-9 &()\"+\$?.:]")),
                            ],
                            textCapitalization: TextCapitalization.words,
                            controller: favouriteMovieSeriesController,
                            // onChanged: (value) {},
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: "The best you have ever seen",
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
                    SizedBox(height: config.kDefaultPadding * 1.4),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.87,
              child: Container(
                width: size.width,
                height: 49,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FunctionButton(
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .set({
                          "userBio": addBioController.text,
                          "username": usernameController.text,
                          "userQuote": favouriteQuoteController.text,
                          "userFavMovieSeries":
                              favouriteMovieSeriesController.text,
                          "userProfilePicture": downloadUrl,
                        });
                      },
                      width: size.width * 0.7,
                      text: "Save",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        current: "profile",
      ),
    );
  }
}
