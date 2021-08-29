import 'package:f/bloc/stories_bloc/stories_repo.dart';
import 'package:f/components/CardContent.dart';
import 'package:f/components/CardTitle.dart';
import 'package:flutter/material.dart';

class MyMarkers extends StatefulWidget {
  const MyMarkers({Key? key}) : super(key: key);

  @override
  _MyMarkersState createState() => _MyMarkersState();
}

class _MyMarkersState extends State<MyMarkers> {
  List markers = [];
  bool _isLoading = true;
  @override
  void didChangeDependencies() async {
    markers = await getUserStories();
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyMarkers oldWidget) {
    setState(() {
      _isLoading = false;
    });
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff18182a),
        title: Text("Markers"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: markers.length == 0
                  ? Center(child: Text("No markers added yet"))
                  : ListView.builder(
                      itemCount: markers.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18, bottom: 12, top: 12),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            // color: Colors.blueGrey[200],
                            child: Column(
                              children: [
                                CardTitle(
                                  subject: markers[i].subject,
                                  isApproved: markers[i].public,
                                ),
                                CardContent(
                                  story: markers[i].story,
                                  xcord: markers[i].xcord,
                                  ycord: markers[i].ycord,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
    );
  }
}
