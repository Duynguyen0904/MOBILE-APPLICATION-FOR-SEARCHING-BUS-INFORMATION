// ignore_for_file: unused_import, use_key_in_widget_constructors, annotate_overrides, prefer_const_constructors, unnecessary_new, deprecated_member_use, prefer_final_fields, unused_field, override_on_non_overriding_member, prefer_typing_uninitialized_variables, duplicate_import, avoid_web_libraries_in_flutter, unused_local_variable, unused_label, avoid_types_as_parameter_names, non_constant_identifier_names, avoid_print, unused_element, camel_case_types, import_of_legacy_library_into_null_safe
//10.873699764252933,106.80303813961362
import 'dart:async';
import 'dart:convert';
import 'package:busmap/home_menu.dart';
import 'package:busmap/location_service.dart';
import 'package:busmap/navi.dart';
import 'package:busmap/note.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:busmap/get_data.dart';
import 'package:busmap/note.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
//var url1;

class MapScreen extends StatefulWidget {
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  TextEditingController _searchController = TextEditingController();
  List<Note> _notes = <Note>[];
  Future<List<Note>> fetchNotes() async {
    //var url = url1
    var url = 'https://77ee-125-235-239-215.ngrok.io/stations/findbus/08U';
    var response = await http.get(Uri.parse(url));

    var notes = <Note>[];

    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    for (int i = 1; i <= _notes.length; i++) {
      List<LatLng> posi = [
        LatLng(_notes[i].station_lat, _notes[i].station_long),  
        ];
      Marker th1Marker = Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(_notes[i].station_lat, _notes[i].station_long),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      );
      markers.add(th1Marker);
      print(posi);
      setState(() {});
       polyline.add(
         Polyline(polylineId: PolylineId('poly'),
         width: 2,
         color: Colors.blueAccent,
         points: posi
         ),
         );
    }
  }

  late GoogleMapController newGoogleMapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//new code for location package
  Location currentLocation = Location();
  List<Marker> markers = [];
  final Set<Polyline> polyline = {};

  void getLocation() {
    var location = currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude!, loc.longitude!),
        zoom: 17.0,
      )));
    });
  }

  // end of location package
  // current location
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(10.87754733715716, 106.80162827288832), zoom: 15);
  @override
  Widget build(BuildContext context) {
    fetchNotes().then((value) {
      setState(() {
        _notes.addAll(value);
        initialize();
      });
    });
    var locatePosition;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              GoogleMap(
                polylines: polyline.map((e)=>e).toSet(),
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: _initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;
                },
                markers: markers.map((e) => e).toSet(),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      title: Container(
                          child: Text(
                            "BusRoute",
                            style: TextStyle(color: Colors.black),
                          ),
                          alignment: Alignment.topLeft),
                      leading: FlatButton(
                          onPressed: () {
                            // _scaffoldKey.currentState!.openDrawer();
                            showSearch(
                                context: context, delegate: CustomSearch());
                          },
                          child:
                              Image(image: AssetImage("assets/neww_menu.png"))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      margin: EdgeInsets.only(top: 60, left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: _searchController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Original',
                                contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 10)),
                            onChanged: (value) {
                              print(value);
                            },
                          )),
                          IconButton(
                              onPressed: () {
                                LocationService()
                                    .getPlaceId(_searchController.text);
                              },
                              icon: Icon(
                                Icons.place,
                                color: Colors.blueAccent,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Destination',
                                contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 10)),
                            onChanged: (value) {
                              print(value);
                            },
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.place,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(bottom: 100, left: 330),
                child: FlatButton(
                  shape: CircleBorder(),
                  color: Colors.blue,
                  onPressed: getLocation,
                  child: Icon(
                    Icons.location_on,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<String> allData = ['08', '50', '52'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return Card(
            child: ListTile(
                title: Text(
                  result,
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  switch (matchQuery[index]) {
                    case '08':
                      print('tuyen xe 08');
                      //url1='';
                      break;
                    case '50':
                      print('tuyen xe 50');
                      break;
                    case '52':
                      print('tuyen xe 52');
                      break;
                  }
                }),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [];
    for (var item in allData) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return Card(
            child: ListTile(
                title: Text(
                  result,
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  switch (matchQuery[index]) {
                    case '08':
                      print('tuyen xe 08');
                      break;
                    case '50':
                      print('tuyen xe 50');
                      break;
                    case '52':
                      print('tuyen xe 52');
                      break;
                  }
                }),
          );
        });
  }
}
