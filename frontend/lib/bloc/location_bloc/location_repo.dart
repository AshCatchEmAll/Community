import 'dart:convert';

import 'package:f/bloc/auth_bloc/auth_repo.dart';
import 'package:f/bloc/location_bloc/location_model.dart';
import 'package:http/http.dart' as http;

Future<NativeLocation> userLocationToNativeLand(double x, double y) async {
  final response = await http.get(
    Uri.parse(
        'https://native-land.ca/api/index.php?maps=languages&position=$x,$y'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    NativeLocation nl = NativeLocation.fromJson(jsonDecode(response.body)[0]);

    return nl;
  } else {
    throw Exception('Failed to get response from nativeland API ');
  }
}

Future<NativeLocation> nameToNativeLand(String name) async {
  final response = await http.get(
    Uri.parse(
        'https://native-land.ca/wp-json/nativeland/v1/api/index.php?maps=territories&name=$name'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    NativeLocation nl = NativeLocation.fromJson(jsonDecode(response.body)[0]);

    return nl;
  } else {
    throw Exception('Failed to get response from nativeland API ');
  }
}
