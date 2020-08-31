import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mango_driver/models/rider_request.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  Future<void> addRiderRequest(
      RiderRequest initialRequest, BuildContext context) async {
    print("adding request");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'addRiderRequest',
    );
    callable.call(initialRequest.toJson()).then((resp) {
      print("print response addRiderRequest:");
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

  //TODO MAKE THIS BETTER
  Future<List<RiderRequest>> getNearbyRequests(LatLng driverLocation) async {
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

    print("getting requests");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getNearbyRequests',
    );
    var data = {
      'sourceLat': driverLocation.latitude,
      'sourceLng': driverLocation.longitude,
    };

    var resp = await callable.call(data);

    List<RiderRequest> requests = [];

    for (int i = 0; i < resp.data.length; i++) {
      print("documentData:");
//        print(resp.data[i]);
//        print(resp.data[i].runtimeType);
      var documentData = resp.data[i]["documentData"];
      //print(documentData);
      var distance = resp.data[i]["distance"];
      RiderRequest request = RiderRequest.fromJson(documentData);
      request.setDistance(distance);
      requests.add(request);

//        offer.setDistance(distance);
//        offers.add(offer);
    }
    print("\n\n\n\n\nPRINTING THE REQUESTS LIST");
    print(requests);
    print("DONE PRINTING REQUESTS LIST\n\n\n\n\n");
    return requests;

//    callable.call(data).then((resp) {
//      print(resp.data.runtimeType);
//
//    });
  }
}
