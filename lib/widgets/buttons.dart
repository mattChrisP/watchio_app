import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';

class FunctionButton extends StatelessWidget {
  final Function onTap;
  final double width;
  final String text;

  const FunctionButton({Key key, this.onTap, this.width, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.width,
        decoration: BoxDecoration(
          color: config.mediumPurple,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // onTap: press,
            onTap: this.onTap,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  this.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: "MackinacBook",
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
