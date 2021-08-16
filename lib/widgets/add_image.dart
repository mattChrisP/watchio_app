import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reorderables/reorderables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

class AnimeImagesEdit extends StatefulWidget {
  final String animeId;

  const AnimeImagesEdit({Key key, this.animeId}) : super(key: key);

  @override
  _AnimeImagesEditState createState() => _AnimeImagesEditState();
}

class _AnimeImagesEditState extends State<AnimeImagesEdit> {
  List<dynamic> images = [];
  List<Widget> _rows;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getData() {
    FirebaseFirestore.instance
        .collection("animes")
        .doc(widget.animeId)
        .collection("images")
        .orderBy("order", descending: false)
        .get()
        .then((imagesSnapshot) {
      this.setState(() {
        this.images = imagesSnapshot.docs.map((imageSnapshot) {
          var imageData = imageSnapshot.data();
          imageData["id"] = imageSnapshot.id;
          return imageData;
        }).toList();
      });
    });
  }

  @override
  void initState() {
    this.getData();
    _rows = List<Widget>.generate(
        50,
        (int index) => Text('This is row $index',
            key: ValueKey(index), textScaleFactor: 1.5));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 116,
        child: Builder(builder: (context) {
          var children = <Widget>[];
          children = this
              .images
              .map((imageData) {
                return Padding(
                  key: ValueKey(imageData["order"]),
                  padding: EdgeInsets.all(8),
                  child: Stack(overflow: Overflow.visible, children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(imageData["image_url"]),
                            // AssetImage("assets/images/kimetsu_movie.png"),
                          ),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    Positioned(
                      right: -10,
                      top: -10,
                      child: InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection("animes")
                              .doc(widget.animeId)
                              .collection("images")
                              .doc(imageData["id"])
                              .delete();

                          final firebaseStorageRef = FirebaseStorage.instance
                              .ref()
                              .child(
                                  "animes/${widget.animeId}/${imageData['id']}");
                          await firebaseStorageRef.delete();
                          final firebaseStorageRef2 = FirebaseStorage.instance
                              .ref()
                              .child(
                                  "animes/${widget.animeId}/thumbnail/${imageData['id']}");
                          await firebaseStorageRef2.delete();
                          var length = this.images.length;
                          setState(() {
                            this
                                .images
                                .removeAt(imageData["order"] + length - 1);
                            length -= 1;
                            for (var i = 0; i < length; i++) {
                              var newOrder = -(length - i - 1);
                              this.images[i]["order"] = newOrder;
                              FirebaseFirestore.instance
                                  .collection("animes")
                                  .doc(widget.animeId)
                                  .collection("images")
                                  .doc(this.images[i]["id"])
                                  .update({"order": newOrder});
                            }
                          });
                        },
                        child: Container(
                          child: Icon(
                            Icons.close,
                            color: Colors.black45,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                );
              })
              .toList()
              .cast<Widget>();
          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                key: ValueKey(0),
                padding: EdgeInsets.all(8),
                child: MaterialButton(
                  height: 100,
                  onPressed: () async {
                    var file = await ImagePicker().getImage(
                        // maxHeight: 800,
                        // maxWidth: 800,
                        source: ImageSource.gallery,
                        imageQuality: 100);
                    print("filepath: " + file.path);
                    File croppedFile = await ImageCropper.cropImage(
                        sourcePath: file.path,
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
                    // croppedFile.path
                    // Image image = decodeImage(new Io.File('test.jpg').readAsBytesSync());

                    // // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
                    // Image thumbnail = copyResize(image, width: 120);
                    if (croppedFile == null) {
                      return;
                    }
                    Directory tempDir = await getTemporaryDirectory();
                    var newImageId = Uuid().v4();
                    File image = await FlutterImageCompress.compressAndGetFile(
                      croppedFile.absolute.path,
                      "${tempDir.absolute.path}/image_${basename(croppedFile.path)}",
                      minWidth: 700,
                      minHeight: 700,
                      quality: 50,
                    );
                    final firebaseStorageRef = FirebaseStorage.instance
                        .ref()
                        .child("animes/${widget.animeId}/${newImageId}");
                    await firebaseStorageRef.putFile(image);
                    var downloadUrl = await firebaseStorageRef.getDownloadURL();
                    var json = {
                      "image_url": downloadUrl,
                      "order": -children.length
                    };

                    await FirebaseFirestore.instance
                        .collection("animes")
                        .doc(widget.animeId)
                        .collection("images")
                        .doc(newImageId)
                        .set(json);

                    // await FirebaseFirestore.instance
                    //     .collection("animes")
                    //     .doc(widget.animeId)
                    //     .set({
                    //   "image_url": downloadUrl,
                    //   // "thumbnail_url": downloadUrlThumbnail
                    // });

                    json["id"] = newImageId;

                    this.setState(() {
                      images.insert(0, json);
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_camera,
                        size: 30,
                      ),
                      Text(
                        "Add a photo",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: "MackinacBook",
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
              ReorderableRow(
                scrollController: ScrollController(),
                crossAxisAlignment: CrossAxisAlignment.start,
                onReorder: (int oldIndex, int newIndex) {
                  var movedImage = this.images.removeAt(oldIndex);
                  this.images.insert(newIndex, movedImage);
                  var length = this.images.length;
                  for (var i = 0; i < length; i++) {
                    var newOrder = -(length - i - 1);
                    this.images[i]["order"] = newOrder;
                    FirebaseFirestore.instance
                        .collection("animes")
                        .doc(widget.animeId)
                        .collection("images")
                        .doc(this.images[i]["id"])
                        .update({"order": newOrder});
                  }
                  FirebaseFirestore.instance
                      .collection("animes")
                      .doc(widget.animeId)
                      .update({
                    "image_url": this.images[0]["image_url"],
                  });
                  this.setState(() {});
                },
                children: children,
                onNoReorder: (int index) {
                  //this callback is optional
                  // debugPrint(
                  //     '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                },
              ),
            ],
          );
        }));
  }
}
