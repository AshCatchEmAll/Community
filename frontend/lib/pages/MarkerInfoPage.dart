import 'package:f/bloc/auth_bloc/auth_repo.dart';
import 'package:f/bloc/stories_bloc/stories_model.dart';
import 'package:f/bloc/stories_bloc/stories_repo.dart';
import 'package:flutter/material.dart';

class MarkerInfoPage extends StatefulWidget {
  MarkerInfoPage(
      {Key? key, required this.name, required this.x, required this.y})
      : super(key: key);
  final String name;
  double x;
  double y;

  @override
  _MarkerInfoPageState createState() => _MarkerInfoPageState();
}

class _MarkerInfoPageState extends State<MarkerInfoPage> {
  String subject = "";

  String message = "";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Add information about ${widget.name}",
                      style: TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      subject = value;
                    },
                    decoration: new InputDecoration(
                      labelText: "Subject",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      message = value;
                    },
                    maxLines: 10,
                    decoration: new InputDecoration(
                      labelText: "Your message.",

                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    await addStory(Story(
                        subject: subject,
                        xcord: widget.x,
                        ycord: widget.y,
                        story: message));
                    setState(() {
                      _isLoading = false;
                      message = "";
                      subject = "";
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            "Request is submitted and is waiting for approval")));
                  },
                  child: _isLoading
                      ? SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ))
                      : Text("Add"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
