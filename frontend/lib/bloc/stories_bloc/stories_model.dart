import 'package:flutter/foundation.dart';

class Story {
  Story({
    this.id,
    required this.xcord,
    required this.ycord,
    required this.story,
    required this.subject,
    this.public = false,
  });
  String? id;
  String story;
  bool public;
  String subject;
  double xcord;
  double ycord;
  toMap() {
    return {
      "story": story,
      "xcord": xcord,
      "ycord": ycord,
      "subject": subject,
      "public": public
    };
  }

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
        story: json['story'],
        xcord: json['xcord'],
        ycord: json['ycord'],
        public: json["public"],
        subject: json["subject"]);
  }
}
