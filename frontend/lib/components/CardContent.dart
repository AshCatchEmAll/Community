import 'package:f/components/Tags.dart';
import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  const CardContent({
    Key? key,
    required this.story,
    required this.xcord,
    required this.ycord,
  }) : super(key: key);
  final String story;

  final double xcord;
  final double ycord;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,

      // color: Colors.blueGrey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 8, top: 4),
              child: Text(
                story,
                textAlign: TextAlign.left,
                textScaleFactor: 1.2,
                style: TextStyle(
                  fontFamily: "nunito",
                  color: Colors.black,
                ),
                softWrap: true,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TagsComponent(
                        color: Color(0xff4e4e4e),
                        tagName: xcord.toStringAsPrecision(4),
                      ),
                      TagsComponent(
                        color: Color(0xff4e4e4e),
                        tagName: ycord.toStringAsPrecision(4),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
