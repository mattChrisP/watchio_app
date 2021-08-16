import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/bottom_nav_bar.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: ExploreHeader(),
            child: Container(height: 200, color: config.mediumPurple),
          ),
          Container(
            height: 120,
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
                      color: config.lightSilverBlue,
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {},
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
        ],
      ),
      bottomNavigationBar: BottomNavBar(current: "explore"),
    );
  }
}

class ExploreHeader extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    var endPoint1 = Offset(size.width * 0.5, size.height - 35);
    var controlPoint1 = Offset(size.width * 0.25, size.height - 50);
    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);

    var endPoint2 = Offset(size.width, size.height - 80);
    var controlPoint2 = Offset(size.width * 0.75, size.height - 10);
    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
