import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mango_driver/models/rider_offer.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  Future<void> addRiderOffer(
      RiderOffer initialOffer, BuildContext context) async {
    print("adding offer");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'addRiderOffer',
    );
    callable.call(initialOffer.toJson()).then((resp) {
      print("print response addRiderOffer:");
      print(resp);
      print(resp.runtimeType);
    }).catchError((err) {
      print(err);
    });
//    dynamic resp = await callable.call(initialOffer.toJson());
//    print("print response:");
//    print(resp);
//    print(resp.runtimeType);
  }

  //TODO RUN QUERYING THROUGH CLOUD FUNCTIONS
  Future<List<RiderOffer>> getNearbyOffers(LatLng driverLocation) {
    // var queryRef =
    //     _db.collection('riderOffers').where('accepted', isEqualTo: false);
    // print("printing query list:");
    // queryRef
    //     .snapshots()
    //     .map((snapshot) => snapshot.documents
    //         .map((document) => RiderOffer.fromJson(document.data))
    //         .toList())
    //     .forEach((element) {
    //   element.forEach((element) => print(element.toJson()));
    // });
    // print("driverlat: " + driverLocation.latitude.toString());
    // print("driverlong: " + driverLocation.longitude.toString());
    // GeoFirePoint center = geo.point(
    //     latitude: driverLocation.latitude, longitude: driverLocation.longitude);
    // Stream<List<RiderOffer>> temp = geo
    //     .collection(collectionRef: queryRef)
    //     .within(center: center, radius: 100, field: 'sourceGeoPoint')
    //     .map((documentSnapList) => documentSnapList.map((document) {
    //           Map<String, dynamic> data = document.data;
    //           print(RiderOffer.fromJson(data));
    //           return RiderOffer.fromJson(data);
    //         }).toList());
    // temp.listen((event) {
    //   print("\n\n\n\n\n\n\n\n\n\n\n\n\nPRINTING THE THING");
    //   print(event);
    //   print("\n\n\n\n\n\n\n\n\n\n\n\n");
    // });
    // return temp;

    print("getting offers");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getNearbyOffers',
    );
    var data = {
      'sourceLat': driverLocation.latitude,
      'sourceLng': driverLocation.longitude,
    };
    callable.call(data).then((resp) {
      print(resp.data.runtimeType);
      List<RiderOffer> offers = [];

      for (int i = 0; i < resp.data.length; i++) {
        print(resp.data[i]);
        print(resp.data[i].runtimeType);

        //gets each "location" object
        Map<String, dynamic> data = json.decode(resp.data[i]);
        print(data);
        print(data.keys);
        var documentData = data["documentData"];
        var distance = data["distance"];
        print("printing documentdata:");
        print(documentData);
        print("printing sourceLat:");
        print(documentData["sourceLat"]);
        print(documentData.runtimeType);
        print("printing distance");
        print(distance);
//        Map<String, String> documentDataMap =
//            jsonDecode(documentData) as Map<String, String>;
        Map<String, dynamic> documentDataMap = Map<String, dynamic>.from(jsonDecode(documentData));
        print(documentDataMap);
        RiderOffer offer = RiderOffer.fromJson(documentDataMap);
        print("\n\nPRINTING DISTANCE RUNTIME TYPE:");
        print(distance.runtimeType);
        offer.setDistance(distance);
        offers.add(offer);
      }
      print("\n\n\n\n\nPRINTING THE OFFERS LIST");
      print(offers);
      print("DONE PRINTING OFFERS LIST\N\N\N\N\N");
      return offers;
    }).catchError((err) {
      print(err);
    });
  }
}
