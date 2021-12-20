import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';
import 'package:watchlist_app/widgets/display_people.dart';
import 'package:watchlist_app/widgets/loading.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Map> usersInfo = [];

  Future getAllUser() async {
    dynamic data = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();
    for (var i = 0; i < data.docs.length; i++) {
      this.usersInfo.add(data.docs[i].data());
    }
    return this.usersInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: this.getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ExploreBody(
                snapshot: snapshot,
              );
            } else {
              return Loading();
            }
          }),
      bottomNavigationBar: BottomNavBar(current: "explore"),
    );
  }
}

class ExploreBody extends StatelessWidget {
  final dynamic snapshot;

  const ExploreBody({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: size.height,
            color: config.superLightOrange,
          ),
          Container(
            height: config.kDefaultPadding * 6 + 65,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [config.bluenishPurple, config.mediumPurple])),
          ),
          Positioned(
            top: config.kDefaultPadding * 6,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 32.0),
                  child: Container(
                    height: 50,
                    width: size.width * 0.8,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: SvgPicture.asset("assets/icons/search.svg"),
                        hintText: "Search for other people",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.42),
                          fontFamily: "MackinacBook",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.2 + config.kDefaultPadding,
            child: Container(
              width: size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: config.kDefaultPadding),
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DisplayPeople(
                          userInfo: snapshot.data[index],
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        thickness: 1,
                      ),
                      Text("End"),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
