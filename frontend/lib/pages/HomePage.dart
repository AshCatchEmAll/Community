import 'dart:convert';
import 'dart:ui';

import 'package:f/bloc/location_bloc/location_model.dart';
import 'package:f/bloc/location_bloc/location_repo.dart';
import 'package:f/bloc/stories_bloc/stories_model.dart';
import 'package:f/bloc/stories_bloc/stories_repo.dart';
import 'package:f/components/MyDrawer.dart';
import 'package:f/constants/Territories.dart';
import 'package:f/constants/TerritoriesName.dart';
import 'package:f/pages/MarkerInfoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:f/bloc/auth_bloc/auth_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthBloc _authBloc;
  late GoogleMapController mapController;
  List<LatLng> polygonCoords = [];
  Set<Polygon> polygonSet = new Set();
  bool _isLoading = true;
  late NativeLocation nl;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Polygon> myPolygon() {
    polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));

    polygonSet.add(Polygon(
        polygonId: PolygonId('test'),
        points: polygonCoords,
        strokeColor: Colors.red));

    return polygonSet;
  }

  updatePolygon(List a, String id, Color color) {
    polygonCoords.clear();
    polygonSet.clear();
    a.forEach((element) {
      polygonCoords.add(LatLng(element[1], element[0]));
    });

    polygonSet.add(Polygon(
        polygonId: PolygonId(id),
        points: polygonCoords,
        fillColor: color.withOpacity(0.5),
        strokeWidth: 2,
        strokeColor: Colors.red));

    // polygonSet.elementAt(0).points.forEach((element) {
    //   print(element);
    // });
  }

  getLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    LatLng lng = LatLng(_locationData.latitude ?? 56.1304,
        _locationData.longitude ?? -106.3468);

    nl = await userLocationToNativeLand(lng.latitude, lng.longitude);
    await updatePolygon(nl.polygon, nl.name, nl.color);
    await mapController
        .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lng.latitude, lng.longitude),
      zoom: 8,
    )));
    setState(() {
      _isLoading = false;
    });

    return lng;
  }

  Future _addMarkerLongPressed(LatLng latlang) async {
    setState(() {
      _isLoading = true;
    });
    NativeLocation n =
        await userLocationToNativeLand(latlang.latitude, latlang.longitude);
    final MarkerId markerId = MarkerId(latlang.latitude.toString());
    Marker marker = Marker(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MarkerInfoPage(
            x: latlang.latitude,
            y: latlang.longitude,
            name: n.name,
          );
        }));
      },
      markerId: markerId,
      draggable: true,
      position: latlang,
      infoWindow: InfoWindow(
        title: n.name,
        snippet: "Click to add info",
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    markers[markerId] = marker;
    setState(() {
      _isLoading = false;
    });

    await mapController
        .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latlang.latitude, latlang.longitude),
      zoom: 8,
    )));
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  handleTerritoryCardClick(String name) async {
    setState(() {
      _isLoading = true;
    });
    NativeLocation n = await nameToNativeLand(name);
    polygonCoords.clear();
    polygonSet.clear();
    n.polygon.forEach((element) {
      polygonCoords.add(LatLng(element[1], element[0]));
    });

    polygonSet.add(Polygon(
        polygonId: PolygonId(DateTime.now().millisecondsSinceEpoch.toString()),
        points: polygonCoords,
        fillColor: n.color.withOpacity(0.5),
        strokeWidth: 2,
        strokeColor: Colors.red));

    setState(() {
      _isLoading = false;
    });

    await mapController
        .moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(polygonCoords[0].latitude, polygonCoords[0].longitude),
      zoom: 8,
    )));
  }

  handleExploreFAB() async {
    return await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: territoriesNames.length,
                  itemBuilder: (context, i) {
                    return StatefulBuilder(
                      builder: (context, setstate) {
                        bool loading = false;
                        return GestureDetector(
                          key: Key(i.toString()),
                          onTap: () async {
                            setstate(() {
                              loading = true;
                              print("GG");
                            });
                            await handleTerritoryCardClick(
                                territories[i]["slug"].toString());
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Center(
                                  child: loading
                                      ? CircularProgressIndicator()
                                      : Text(
                                          territories[i]["name"].toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }));
        });
  }

  handleInfoFAB() async {
    return await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      "You are located in ${nl.name}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  final LatLng _center = const LatLng(56.1304, -106.3468);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await getLocation();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(authBloc: _authBloc),
      appBar: AppBar(
        title: Text('Where am I'),
        backgroundColor: Color(0xff18182a),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        polygons: polygonSet,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 5,
        ),
        onLongPress: (latlang) {
          _addMarkerLongPressed(latlang);
        },
        markers: Set<Marker>.of(markers.values),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              onPressed: () async {
                await handleInfoFAB();
              },
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Icon(Icons.info_outline_rounded)),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
              onPressed: () async {
                await handleExploreFAB();
              },
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Icon(Icons.explore_rounded)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
