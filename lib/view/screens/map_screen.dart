import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapScreen extends StatefulWidget {

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}
//  TODO : use bloc pattern
class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(39.416198, 35.017957),
    zoom: 5,
  );


  void _add(LatLng l) {
    var markerIdVal = "1";
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:l,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocationPermission();

  }


  getLocationPermission() async {
    var location = Location();
    try {
      location.requestPermission(); //to lunch location permission popup
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint('Permission denied');
      }
    }
  }

//test
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GoogleMap(
        mapToolbarEnabled: false,
        padding: const EdgeInsets.only(top: 40.0,),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled:true,
        markers:  Set<Marker>.of(markers.values),
        initialCameraPosition: _initialPosition,
        onLongPress: (l) => _add(l),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToLocation,
        label: const Text('Şikayetim Var'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _goToLocation() async {
   // final GoogleMapController controller = await _controller.future;
  }
}