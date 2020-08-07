import 'package:flutter/cupertino.dart';

class RiderOffer {
  num price;
  String destination;
  num destinationLat;
  num destinationLng;
  String source;
  num sourceLat;
  num sourceLng;
  double distance;
  String riderName;
//  GeoFirePoint myLocation;

  RiderOffer(
      {@required this.price,
      @required this.destination,
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
  RiderOffer.fromJson(Map<dynamic, dynamic> parsedJson) {
//    if (parsedJson["price"] is int) {
//      price = parsedJson['price'].toDouble();
//    } else {
//      price = parsedJson['price'];
//    }
    price = parsedJson['price'];
    destination = parsedJson['destination'];
    destinationLat = parsedJson['destinationLat'];
    destinationLng = parsedJson['destinationLng'];
    source = parsedJson['source'];
    sourceLat = parsedJson['sourceLat'];
    sourceLng = parsedJson['sourceLng'];
    riderName = parsedJson['riderName'];
    //distance = parsedJson['distance'];
    //Geoflutterfire geo = Geoflutterfire();
    //myLocation = parsedJson["geohash"];
  }

  void setDistance(double distance_param) {
    distance = distance_param;
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
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
