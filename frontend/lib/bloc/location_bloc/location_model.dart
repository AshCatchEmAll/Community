import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class NativeLocation {
  NativeLocation(
      {required this.name,
      required this.description,
      required this.color,
      required this.polygon});

  final String name;
  final String description;
  final Color color;
  final List polygon;
  toMap() {
    return {
      "name": name,
      "description": description,
      "color": color.toHex(),
      "polygon": polygon
    };
  }

  factory NativeLocation.fromJson(Map<String, dynamic> json) {
    return NativeLocation(
      polygon: json["geometry"]["coordinates"][0],
      name: json["properties"]['Name'],
      description: json["properties"]['description'],
      color: HexColor.fromHex(json["properties"]['color']),
    );
  }
}
