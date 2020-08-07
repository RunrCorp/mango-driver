import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_fluttoffer.dart';
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
      appBar: AppBar(title: Text("Nearby Ride Requests")),
      body: _buildPanel(context),
    );
  }

  Future<double> counterOfferDialog(BuildContext context) {
    final controller = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Make a counter offer"),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Enter an amount"),
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              ButtonTheme(
                minWidth: screenWidth / 4,
                child: RaisedButton(
                    textColor: Colors.grey,
                    color: Colors.white,
                    child: Text("Return"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              ButtonTheme(
                minWidth: screenWidth / 4,
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.red,
                    child: Text("Confirm"),
                    onPressed: () {
                      Navigator.of(context).pop(double.parse(controller.text));
                    }),
              ),
            ],
          );
        });
  }

  Widget _buildPanel(BuildContext context) {
    Position location = Provider.of<Position>(context);
    LatLng driverLocation = LatLng(location.latitude, location.longitude);
    // final riderOffers = Provider.of<List<RiderOffer>>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    //TODO FORMAT THIS MUCH BETTER
    return FutureBuilder(
        future: FirestoreService().getNearbyOffers(driverLocation),
        initialData: [],
        builder: (context, snapshot) {
          var riderOffers = snapshot.data;
          if (snapshot.data.length > 0) {
            print("\n\n\n\nPRINTING VALUE OF SNAPSHOT");
            print(snapshot.data);
            print(snapshot.data[0]);
            print(snapshot.data[0].runtimeType);
            print("DONE PRINTING VALUE OF SNAPSHOT\n\n\n\n\n\n");
            return ListView.builder(
              itemCount: riderOffers.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    leading: Text(riderOffers[index].riderName),
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(riderOffers[index].destination,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black)),
                          Text(
                            riderOffers[index].price.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                              "Distance in km: " +
                                  riderOffers[index].distance.toString(),
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black)),
                        ]),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              riderOffers[index].sourceLat.toString() + ": Lat",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              )),
                          Text(
                              "Long: " +
                                  riderOffers[index].sourceLng.toString(),
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 28,
                              )),
                        ]),
                    children: <Widget>[
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: screenWidth / 4,
                            child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.green,
                                child: Text("Accept"),
                                onPressed: () {}),
                          ),
                          ButtonTheme(
                            minWidth: screenWidth / 4,
                            child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.red,
                                child: Text("Reject"),
                                onPressed: () {
                                  setState(() {
                                    riderOffers.removeWhere((thisOffer) =>
                                        riderOffers[index] == thisOffer);
                                  });
                                }),
                          ),
                          ButtonTheme(
                            minWidth: screenWidth / 4,
                            child: RaisedButton(
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Text("Counter"),
                                onPressed: () {
                                  counterOfferDialog(context).then((onValue) {
                                    print(onValue);
                                  });
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });

    // Widget __buildPanel(BuildContext context) {
    //   final screenWidth = MediaQuery.of(context).size.width;
    //   return ExpansionPanelList(
    //     expansionCallback: (int index, bool isExpanded) {
    //       setState(() {
    //         riderOffers
    //        [index].isExpanded = !isExpanded;
    //       });
    //     },
    //     children: riderOffers
    //    .map<ExpansionPanel>((PendingOffer offer) {
    //       return ExpansionPanel(
    //         headerBuilder: (BuildContext context, bool isExpanded) {
    //           return ListTile(
    //             leading: offer.picture,
    //             title: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Text(offer.driverName,
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.bold, fontSize: 18)),
    //                   Text(offer.rating.toString()),
    //                   Text(offer.vehicleName, style: TextStyle(fontSize: 10)),
    //                 ]),
    //             trailing: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: <Widget>[
    //                   Text(offer.minutesAway.toString() + " min away",
    //                       style: TextStyle(
    //                         color: Colors.red,
    //                         fontSize: 12,
    //                       )),
    //                   Text("\$" + offer.cost.toStringAsFixed(2),
    //                       style: TextStyle(
    //                         color: Colors.green,
    //                         fontSize: 32,
    //                       )),
    //                 ]),
    //           );
    //         },
    //         body: ButtonBar(
    //             alignment: MainAxisAlignment.spaceEvenly,
    //             children: <Widget>[
    //               ButtonTheme(
    //                 minWidth: screenWidth / 4,
    //                 child: RaisedButton(
    //                     textColor: Colors.white,
    //                     color: Colors.green,
    //                     child: Text("Accept"),
    //                     onPressed: () {}),
    //               ),
    //               ButtonTheme(
    //                 minWidth: screenWidth / 4,
    //                 child: RaisedButton(
    //                     textColor: Colors.white,
    //                     color: Colors.red,
    //                     child: Text("Reject"),
    //                     onPressed: () {
    //                       setState(() {
    //                         riderOffers
    //                             .removeWhere((thisOffer) => offer == thisOffer);
    //                       });
    //                     }),
    //               ),
    //               ButtonTheme(
    //                 minWidth: screenWidth / 4,
    //                 child: RaisedButton(
    //                     textColor: Colors.white,
    //                     color: Colors.blue,
    //                     child: Text("Counter"),
    //                     onPressed: () {
    //                       counterOfferDialog(context).then((onValue) {
    //                         print(onValue);
    //                       });
    //                     }),
    //               ),
    //             ]),
    //         isExpanded: offer.isExpanded,
    //       );
    //     }).toList(),
    //   );
    // }
  }
}
