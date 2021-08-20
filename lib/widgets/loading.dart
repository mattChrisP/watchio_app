import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: 60,
            height: 60,
            child: SpinKitFadingCircle(size: 60, color: Colors.white)));
  }
}
