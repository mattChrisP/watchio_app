import 'package:flutter/material.dart';
import 'package:watchlist_app/config.dart';
import 'package:watchlist_app/widgets/buttons.dart';

class CustomAlertDialog extends StatelessWidget {
  final String alertText;
  final Function onTap;

  const CustomAlertDialog({Key key, this.alertText, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 350,
        decoration: BoxDecoration(
            color: config.bluenishPurple,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/anime_shock.png',
                  height: 130,
                  width: 120,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: config.lightOrange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  alertText,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontFamily: 'MackinacBook',
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FunctionButton(
                onTap: onTap,
                width: size.width * 0.5,
                text: "OK",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
