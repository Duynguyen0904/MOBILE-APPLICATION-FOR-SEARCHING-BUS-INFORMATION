// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, deprecated_member_use, prefer_collection_literals, prefer_final_fields, unused_field, duplicate_import

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:busmap/note.dart';

class DataFromAPI extends StatefulWidget {
  @override 
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI>{

List<Note> _notes = <Note>[];
  Future<List<Note>> fetchNotes() async {
    var url = 'https://462a-125-234-120-118.ngrok.io/stations/findbus/08U';
    var response = await http.get(Uri.parse(url));
    
    var notes = <Note>[];

    if (response.statusCode == 200){
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        notes.add(Note.fromJson(noteJson));
      }
    }
    return notes;
  }

  @override 
  Widget build(BuildContext context){
    fetchNotes().then((value){
      setState(() {
        
      _notes.addAll(value);
            });

    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus station'),
      ),
      body: ListView.builder( 
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Text(_notes[index].station_long.toString()),
                Text(_notes[index].station_lat.toString()),
              ],
            ),
          );
        },
        itemCount: _notes.length,
      )
    );
}
}
