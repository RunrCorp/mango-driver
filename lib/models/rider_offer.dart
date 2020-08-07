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
//SHOULD BE A MAP OF STRING, STRING, BUT DYNAMIC IS NECESSARY TO MAKE IT WORK
  RiderOffer.fromJson(Map<String, dynamic> parsedJson) {
    print("calling fromJson");

    print(parsedJson);
    print(parsedJson["price"]);
    print(parsedJson["pricee"].runtimeType);
    price = double.parse(parsedJson['price']);
    print("got price");
    destination = parsedJson['destination'];
    destinationLat = double.parse(parsedJson['destinationLat']);
    destinationLng = double.parse(parsedJson['destinationLng']);
    source = parsedJson['source'];
    sourceLat = double.parse(parsedJson['sourceLat']);
    sourceLng = double.parse(parsedJson['sourceLng']);
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
