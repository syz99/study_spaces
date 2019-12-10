import 'dart:async';

//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//api key = AIzaSyDQKkNsepBOaIiSSp4OUIFZGKmCOFTrho4
class SearchSpaces extends StatelessWidget {
  SearchSpaces({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //return new MapSample();
    return new CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Google Maps View'),
        ),
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(children: <Widget>[
          new SizedBox(height: 750, child: new MapSample()),
    ])),
    );
  }

}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
//  GoogleMapController mapController;
//
//  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
//  }
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition duke_chapel = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(36.0019, -78.9403),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(
            child:
            GoogleMap(
              mapType: MapType.terrain   ,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),

          CupertinoButton(
            child: const Text('To Duke Chapel'),
            //icon: Icon(Icons.book),
            padding: EdgeInsets.zero,
            onPressed: _goToTheLake,
          )
        ]
      )
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _goToTheLake,
//        label: Text('To Duke Chapel'),
//        icon: Icon(Icons.book),
//      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(duke_chapel));
  }
}

