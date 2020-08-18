import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:mango_driver/models/pending_offer_db.dart';
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

  Stream<List<PendingOfferDb>> getPendingOffers() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      return _db
          .collection('pendingOffers')
          .where("driverUid", isEqualTo: user.uid)
          .where("currentOffer", isEqualTo: true)
          .orderBy("timestamp")
          .snapshots()
          .map((snapshot) => snapshot.documents
              .map((document) => PendingOfferDb.fromJson(document.data))
              .toList());
    });

    //return null;
  }

  //TODO

  void sendCounterOffer() {}

  Future<void> sendNewPendingOffer(PendingOfferDb newPendingOffer) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'sendNewPendingOffer',
    );

    var resp = await callable.call(newPendingOffer.toInitialJson());
    print(resp.data);
  }
}
