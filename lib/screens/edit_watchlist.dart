import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';
import 'package:watchlist_app/widgets/editable_card.dart';

class EditWatchlist extends StatelessWidget {
  static const routeName = '/edit_watchlist';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 3,
              color: config.superLightOrange,
            ),
            Container(
              width: size.width,
              height: size.height * 0.4,
              color: config.mediumPurple,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: config.kDefaultPadding * 4),
                    child: Text(
                      "Add or Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        letterSpacing: 1.5,
                        fontFamily: 'MackinacBook',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: config.kDefaultPadding),
                    child: Text(
                      "Watchlist",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 32,
                        letterSpacing: 1.5,
                        fontFamily: 'MackinacBook',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: size.height * 0.3,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                    color: config.superLightOrange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    )),
              ),
            ),
            Positioned(
              top: size.height * 0.37,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/add_watchlist',
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.1,
                            bottom: config.kDefaultPadding),
                        child: Container(
                          width: size.width * 0.8,
                          height: 150,
                          padding: EdgeInsets.all(config.kDefaultPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                            border: Border.all(color: Colors.white, width: 5),
                            color: config.lightSilverBlue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                              ),
                              Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  fontFamily: 'MackinacBook',
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                "Watchlist",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  fontFamily: 'MackinacBook',
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: config.kDefaultPadding * 2),
                      child: InkWell(
                        child: Container(
                          width: size.width * 0.8,
                          child: GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 8,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) => EditableCard(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: config.kDefaultPadding),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        current: "watchlist",
      ),
    );
  }
}
