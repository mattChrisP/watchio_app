import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';

class InfoPageScreen extends StatelessWidget {
  static const routeName = 'info_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfoPageBody(),
    );
  }
}

class InfoPageBody extends StatefulWidget {
  const InfoPageBody({Key key}) : super(key: key);

  @override
  _InfoPageBodyState createState() => _InfoPageBodyState();
}

class _InfoPageBodyState extends State<InfoPageBody> {
  int _current = 0;

  List<dynamic> infoList = [
    {
      'header': 'Watch Movies / Serials \nof Your Choice',
      'sub_header':
          'Add movies or serials and keep track of the movies / serials that you have watched',
      'image': 'assets/images/howto_21.jpg',
    },
    {
      'header': 'All Your \nFavourites',
      'sub_header':
          'Decide which movies / serials to be your favourite and you can also store memorable moments in form of pictures',
      'image': 'assets/images/howto_23.jpg',
    },
    {
      'header': 'Unique for you',
      'sub_header':
          'Your watchlist is unique for you and you can see other people watchlist as well',
      'image': 'assets/images/howto_22.jpg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: config.kDefaultPadding * 3),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: config.kDefaultPadding / 3),
                      Text(
                        "The Watchers",
                        style: TextStyle(
                          fontFamily: "MackinacBook",
                          color: Color(0xff651511),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login_page',
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontFamily: 'MackinacBook',
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                      initialPage: 0,
                      height: size.height * 0.9,
                      viewportFraction: 1,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: infoList
                      .map((item) => SlideInfo(info: item, value: _current))
                      .toList(),
                )),
              ),
            ),
            SizedBox(height: config.kDefaultPadding),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: size.width / 2,
                        decoration: BoxDecoration(
                          color: Color(0xff651511),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          onTap: () async {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login_page',
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Center(
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'MackinacBook',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: infoList.map((info) {
                          int index = infoList.indexOf(info);
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 6.0,
                              right: 6.0,
                              top: 12.0,
                            ),
                            child: Container(
                              width: 6.0,
                              height: 6.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
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

class SlideInfo extends StatefulWidget {
  final info;
  final value;
  const SlideInfo({Key key, this.info, this.value}) : super(key: key);

  @override
  _SlideInfoState createState() => _SlideInfoState();
}

class _SlideInfoState extends State<SlideInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            widget.info["header"],
            style: TextStyle(
              fontFamily: 'MackinacBook',
              fontSize: 26,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            widget.info["sub_header"],
            style: TextStyle(
              fontFamily: 'MackinacBook',
              fontSize: size.width / 30,
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Container(
            width: size.width,
            height: size.height,
            child: OverflowBox(
              minWidth: 0.0,
              minHeight: 0.0,
              maxWidth: double.infinity,
              child: new Image(
                  image: new AssetImage(widget.info["image"]),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }
}
