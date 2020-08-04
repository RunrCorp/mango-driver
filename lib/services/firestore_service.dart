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
      print("print response:");
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

  Stream<List<RiderOffer>> getRiderOffers(LatLng driverLocation) {
    var queryRef = _db.collection('riderOffers').where('accepted', isEqualTo: false);
    GeoFirePoint center = geo.point(latitude: driverLocation.latitude, longitude: driverLocation.longitude);
    return geo.collection(collectionRef: queryRef).within(center: center, radius: 30, field: 'position');
  }
}
