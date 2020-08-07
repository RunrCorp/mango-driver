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
      print("print response getNearbyOffers:");
      print(resp);
      print(resp.runtimeType);
      print(resp.data);
      List<RiderOffer> offers = [];
      for (int i = 0; i < resp.data.length; i++){
        var documentData = resp.data["documentData"];
        var distance = resp.data["distance"];
        RiderOffer offer = RiderOffer.fromJson(documentData);
        offer.setDistance(distance);
        offers.add(offer);
      }
      print(resp.data.runtimeType);
      return offers;
    }).catchError((err) {
      print(err);
    });
  }
}
