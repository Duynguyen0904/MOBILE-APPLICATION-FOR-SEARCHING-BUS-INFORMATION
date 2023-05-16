// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, unused_field, prefer_final_fields
class Note{
  late double station_long;
  late double station_lat;

  Note(this.station_long, this.station_lat);

  Note.fromJson(Map<String, dynamic> json){
    station_long = json['station_long'];
    station_lat = json['station_lat'];
  }
}
