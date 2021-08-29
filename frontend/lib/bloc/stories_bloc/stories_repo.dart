import 'dart:convert';

import 'package:f/bloc/auth_bloc/auth_repo.dart';
import 'package:f/bloc/stories_bloc/stories_model.dart';
import 'package:f/keys.dart';
import 'package:http/http.dart' as http;

const ip4Add = ip;
Future<http.Response> getOneStory(String docID) async {
  var id = await getUserIdToken();
  var uid = await getUID();
  if (id == null) {
    throw 'Please signup or login';
  }
  final response = await http.get(
    Uri.parse('http://$ip:5000/stories/getOne/$docID'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AuthToken': id,
      'uid': uid,
    },
  );
  if (response.statusCode == 200) {
    Story story = Story.fromJson(jsonDecode(response.body));

    print(story);
  } else {
    throw Exception('Failed to Get album');
  }
  return response;
}

Future<List<Story>> getUserStories() async {
  var uid = await getUID();
  List<Story> s = [];
  var id = await getUserIdToken();
  if (id == null) {
    throw 'Please signup or login';
  }
  final response = await http.get(
    Uri.parse('http://$ip:5000/stories/getUserStories'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AuthToken': id,
      "uid": uid,
    },
  );
  if (response.statusCode == 200) {
    List story = jsonDecode(response.body)["doc"];
    story.forEach((element) {
      print(element);
      s.add(Story(
          story: element["story"],
          subject: element["subject"],
          xcord: element["xcord"],
          ycord: element["ycord"],
          public: element["public"],
          id: element["id"]));
    });
    print(story);
  } else {
    throw Exception('Failed to Get album');
  }
  return s;
}

Future<List<Story>> getAddedStories() async {
  var uid = await getUID();
  List<Story> s = [];
  var id = await getUserIdToken();
  if (id == null) {
    throw 'Please signup or login';
  }
  final response = await http.get(
    Uri.parse('http://$ip:5000/stories/getAddedStories'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AuthToken': id,
      "uid": uid,
    },
  );
  if (response.statusCode == 200) {
    List story = jsonDecode(response.body)["doc"];
    story.forEach((element) {
      print(element);
      s.add(Story(
          story: element["story"],
          subject: element["subject"],
          xcord: element["xcord"],
          ycord: element["ycord"],
          public: true,
          id: element["id"]));
    });
    print(story);
  } else {
    throw Exception('Failed to Get album');
  }
  return s;
}

Future<http.Response> deleteStory(String docID) async {
  var uid = await getUID();
  var id = await getUserIdToken();
  if (id == null) {
    throw 'Please signup or login';
  }
  final response = await http.delete(
    Uri.parse('http://$ip:5000/stories/delete/$docID'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AuthToken': id,
      "uid": uid,
    },
  );
  if (response.statusCode == 200) {
    Story story = Story.fromJson(jsonDecode(response.body));

    print(story);
  } else {
    throw Exception('Failed to Delete Story');
  }
  return response;
}

Future<http.Response> addStory(Story story) async {
  var uid = await getUID();
  var id = await getUserIdToken();
  if (id == null) {
    throw 'Please signup or login';
  }
  final response = await http.post(
    Uri.parse('http://$ip:5000/stories/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AuthToken': id,
      "uid": uid,
    },
    body: jsonEncode(story.toMap()),
  );
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to Add Story');
  }
  return response;
}

Future<http.Response> updateStory(String docID, Story story) async {
  var uid = await getUID();
  var id = await getUserIdToken();
  if (id == null) {
    throw 'Please signup or login';
  }
  final response = await http.patch(
    Uri.parse('http://$ip:5000/stories/update/$docID'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'AuthToken': id,
      "uid": uid
    },
    body: jsonEncode(story.toMap()),
  );
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to Update Story');
  }
  return response;
}
