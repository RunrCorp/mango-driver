import 'package:flutter/cupertino.dart';

class RiderRequest {
  String destination;
  num destinationLat;
  num destinationLng;
  String source;
  num sourceLat;
  num sourceLng;
  num distance;
  String riderName;
  String riderUid;
//  GeoFirePoint myLocation;

  RiderRequest(
      {@required this.destination,
      @required this.destinationLat,
      @required this.destinationLng,
      @required this.source,
      @required this.sourceLat,
      @required this.sourceLng,
      @required this.distance,
      @required this.riderName}) {
    //Geoflutterfire geo = Geoflutterfire();
    //myLocation = geo.point(latitude: this.sourceLat, longitude: this.sourceLng);
  }
//string, dynamic
  RiderRequest.fromJson(Map<dynamic, dynamic> parsedJson) {
    destination = parsedJson['destination'];
    destinationLat = parsedJson['destinationLat'];
    destinationLng = parsedJson['destinationLng'];
    source = parsedJson['source'];
    sourceLat = parsedJson['sourceLat'];
    sourceLng = parsedJson['sourceLng'];
    riderName = parsedJson['riderName'];
    riderUid = parsedJson["riderUid"];
    //distance = parsedJson['distance'];
    //Geoflutterfire geo = Geoflutterfire();
    //myLocation = parsedJson["geohash"];
  }

  void setDistance(num distanceParam) {
    distance = distanceParam;
  }

  Map<String, dynamic> toJson() {
    return {
      "destination": destination,
      "destinationLat": destinationLat,
      "destinationLng": destinationLng,
      "source": source,
      "sourceLat": sourceLat,
      "sourceLng": sourceLng,
      //"geohash": myLocation.data,
    };
  }
}
