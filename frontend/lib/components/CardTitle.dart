import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({
    Key? key,
    required this.subject,
    required this.isApproved,
  }) : super(key: key);
  final String subject;
  final bool isApproved;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13), topRight: Radius.circular(13)),
        color: Colors.teal[800],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 8, top: 8),
                child: Text(
                  subject,
                  softWrap: true,
                  // textScaleFactor: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      fontFamily: "nunito",
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.5, bottom: 7.5, left: 18),
                child: Text(
                  isApproved == true ? "Approved" : "Pending",
                  textScaleFactor: 1.2,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
