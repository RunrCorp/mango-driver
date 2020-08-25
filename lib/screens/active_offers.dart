import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mango_driver/models/rider_request.dart';
import 'package:mango_driver/services/firestore_service.dart';
import 'package:provider/provider.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Active Offers")),
      body: _buildPanel(context),
    );
  }

  Widget _buildPanel(BuildContext context) {
    print("building panel");
    Position location = Provider.of<Position>(context);
    LatLng driverLocation = LatLng(location.latitude, location.longitude);
    // final riderOffers = Provider.of<List<RiderOffer>>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    print("returning future builder");

    //TODO (but not really)
    // We won't be working on this page for a while because the driver
    // can't counter-offer yet. So just don't work on this for now.

    return FutureBuilder(
        //future: FirestoreService().getNearbyOffers(driverLocation),
        //initialData: [],
        // ignore: missing_return
        builder: (context, snapshot) {
          return Center(
                child: Text("Your active offers will appear here."),
          );
        });
  }
}
