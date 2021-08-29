import 'package:f/bloc/stories_bloc/stories_repo.dart';
import 'package:f/components/CardContent.dart';
import 'package:f/components/CardTitle.dart';
import 'package:flutter/material.dart';

class AllTerritories extends StatefulWidget {
  const AllTerritories({Key? key}) : super(key: key);

  @override
  _AllTerritoriesState createState() => _AllTerritoriesState();
}

class _AllTerritoriesState extends State<AllTerritories> {
  List markers = [];
  @override
  void didChangeDependencies() async {
    markers = await getAddedStories();
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Markers"),
      ),
      body: Container(
        child: ListView.builder(
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
