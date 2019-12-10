import 'dart:async';

//import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:study_spaces/components/space_detail.dart';
import 'package:study_spaces/data_models/space.dart';

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

  Position currentLocation;

  @override
  void initState() {
    _currentLocation();
    super.initState();
  }
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.002235, -78.938645),
    zoom: 14.4746,
  );

  static final CameraPosition duke_chapel = CameraPosition(
      //bearing: 192.8334901395799,
      target: LatLng(36.0019, -78.9403),
      //tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // Code for current location
  void _currentLocation() async {
    //final GoogleMapController controller = await _controller.future;
    print("GETTING LOCATION");
    try {
      //currentLocation = await location.getLocation();
      print("made it here");
      Position res = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState((){
        currentLocation = res;
      });
    } on Exception {
      currentLocation = null;
    }
//    controller.animateCamera(CameraUpdate.newCameraPosition(
//      CameraPosition(
//        bearing: 0,
//        target: LatLng(currentLocation.latitude, currentLocation.longitude),
//        zoom: 17.0,
//      ),
//    ));
  }
  @override
  Widget build(BuildContext context) {
    _handleTap(StudySpace space) {
      print("Hello");
      Navigator.of(context).push<void>(CupertinoPageRoute(
        builder: (context) => SpaceDetail(space),
        fullscreenDialog: true,
      ));
    }
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(stream: Firestore.instance.collection('spaces').snapshots(), builder: (context, snapshot){
              if(!snapshot.hasData){
                return Text('Loading');
              }
              else if(currentLocation == null){
                print("NULL");
                return Text("Loading");
              }
              else{
                for(var document in snapshot.data.documents){
                  var doc = document.data;
                  Marker marker = Marker(
                    markerId: MarkerId(doc['name']),
                    infoWindow: InfoWindow(
                        title: "${doc['name']}",
                      ),
                    position: LatLng(doc['latitude'],
                        doc['longitude']),
                    onTap: () =>_handleTap(StudySpace.fromMap(doc)),
                    //onTap:() => _currentLocation()
                  );
                  markers.add(marker);
                }

                // Add my location
//                markers.add(Marker(
//                    markerId: MarkerId("ME"),
//                  infoWindow: InfoWindow(
//                    title: "You",
//                  ),
//                  icon: BitmapDescriptor.defaultMarker,
//                  position: LatLng(currentLocation.latitude,
//                      currentLocation.longitude),
//                ));

                return GoogleMap(
                  mapType: MapType.satellite   ,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                    myLocationEnabled: true,
                  markers: markers
                );
              }
            }
          ),
          ),
          FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue)),
            child: new Text('To Duke Chapel'),
            textColor: Colors.blue,
            onPressed: _goToTheChapel),
//          CupertinoButton(
//            child: const Text('To Duke Chapel'),
//            //icon: Icon(Icons.book),
//            padding: EdgeInsets.zero,
//            onPressed: _goToTheChapel,
//          )
        ]
      )
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _goToTheLake,
//        label: Text('To Duke Chapel'),
//        icon: Icon(Icons.book),
//      ),
    );
  }

  Future<void> _goToTheChapel() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(duke_chapel));
  }
}

