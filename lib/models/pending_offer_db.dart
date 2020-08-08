import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PendingOfferDb {
  String destination;
  num destinationLat;
  num destinationLng;
  num price;
  String source;
  num sourceLat;
  num sourceLng;
  String riderUid;
  String riderName;
  Timestamp timestamp;
  String driverUid; //could leave out
  String driverName; //could leave out
  String initialOfferId;
  bool acceptedByDriver; //could leave out
  bool acceptedByRider; //could leave out
  bool accepted; //could leave out
  bool currentOffer; //could leave out
  int numberOffer;

  PendingOfferDb(
      {@required this.destination,
      @required this.destinationLat,
      @required this.destinationLng,
      @required this.price,
      @required this.source,
      @required this.sourceLat,
      @required this.sourceLng,
      @required this.riderUid,
      @required this.riderName,
      @required this.initialOfferId});

  PendingOfferDb.fromJson(Map<String, dynamic> data)
      : destination = data["destination"],
        destinationLat = data["destinationLat"],
        price = data["price"],
        source = data["source"],
        sourceLat = data["sourceLat"],
        sourceLng = data["sourceLng"],
        riderUid = data["riderUid"],
        riderName = data["riderName"],
        timestamp = data["timestamp"],
        initialOfferId = data["initialOfferId"],
        numberOffer = data["numberOffer"];

  Map<String, dynamic> toInitialJson() {
    return {
      "destination": destination,
      "destinationLat": destinationLat,
      "destinationLng": destinationLng,
      "price": price,
      "source": source,
      "sourceLat": sourceLat,
      "sourceLng": sourceLng,
      "riderUid": riderUid,
      "riderName": riderName,
      "initialOfferId": initialOfferId,
    };
  }
}
