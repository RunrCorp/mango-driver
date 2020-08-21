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
    print("building panel");
    Position location = Provider.of<Position>(context);
    LatLng driverLocation = LatLng(location.latitude, location.longitude);
    // final riderOffers = Provider.of<List<RiderOffer>>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    print("returning future builder");
    //TODO FORMAT THIS MUCH BETTER
    //TODO
    /*
    note to the UI team:
    offers are stored in a RiderOffer Object which is in models/rider_request.dart
    Your job is to display it correctly
     */
    return FutureBuilder(
        future: FirestoreService().getNearbyOffers(driverLocation),
        initialData: [],
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data.length > 0) {
              //TODO UI TEAM DO YOUR WORK IN HERE. THE LIST IS CALLED riderOffers. you got this. i believe in you - arjun
              List<RiderRequest> riderOffers = snapshot.data;
              return ListView.builder(
                itemCount: riderOffers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpansionTile(
                      leading: Text("Picture"),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            riderOffers[index].riderName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          Text(
                            riderOffers[index].distance.toStringAsPrecision(3) +
                                " km drive",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            riderOffers[index].distance.toStringAsPrecision(3) +
                                " km away",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        //TODO: Properly reformat text here
                        Text(
                          "From: " + riderOffers[index].source,
                        ),
                        Text(
                          "To: " + riderOffers[index].destination,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: screenWidth / 4,
                              child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  child: Text("Offer"),
                                  onPressed: () {
                                    counterOfferDialog(context).then((onValue) {
                                      print(onValue);
                                    });
                                  }),
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
                                  child: Text("Open Map"),
                                  onPressed: () {}),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              //no data
              return Center(
                child: Text("No nearby offers to display."),
              );
            }
          } else {
            //still loading
            return Center(
              child: CircularProgressIndicator(),
            );
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
