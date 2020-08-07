import 'package:flutter/cupertino.dart';

class RiderOffer {
  double price;
  String destination;
  double destinationLat;
  double destinationLng;
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

  RiderOffer.fromJson(Map<dynamic, dynamic> parsedJson) {
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
