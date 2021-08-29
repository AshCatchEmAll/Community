// Padding according to the text size
import 'package:flutter/material.dart';

class TagsComponent extends StatelessWidget {
  TagsComponent({required this.tagName, this.color = Colors.white});
  final Color color;
  final String tagName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7),

      constraints: BoxConstraints(maxHeight: 33),
      //

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: color,
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tagName == null ? "" : tagName + " ",
            textAlign: TextAlign.start,
            softWrap: true,
            style: TextStyle(color: Color(0xffc4c4c4), fontFamily: "nunito"),
          ),
        ),
      ),
    );
  }
}
