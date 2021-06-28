import 'package:flutter/material.dart';

class RowofAd extends StatelessWidget {
  final Widget widget;
  final String title;
  final String text;
  RowofAd({this.widget, this.text, this.title});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(width: width * .07, child: widget),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            width: width * .25,
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontFamily: "Oswald"),
              ),
            ),
          ),
        ),
        Container(
          width: width*.05,
          child: Text(
            ":",
            style: TextStyle(fontFamily: "LoraM", fontSize: 14),
          ),
        ),
        Text(
          text,
          style: TextStyle(fontFamily: "LoraM", fontSize: 14),
        ),
      ],
    );
  }
}
