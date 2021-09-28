import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenSettings extends Equatable {
  final List<Marker> markers;
  final Marker? currentMarker;
  final bool myLocationEnabled;
  final CameraPosition initialPosition;


  const MapScreenSettings(
      {required this.markers,
      this.currentMarker,
      this.initialPosition = const CameraPosition(
        target: LatLng(39.416198, 35.017957),
        zoom: 5,
      ),
      this.myLocationEnabled = true});

  @override
  List<Object?> get props => [markers, currentMarker, myLocationEnabled,initialPosition];

  MapScreenSettings copyWith({
    List<Marker>? markers,
    Marker? currentMarker,
    bool? myLocationEnabled,
  }) =>
      MapScreenSettings(
          markers: markers ?? this.markers,
          myLocationEnabled: myLocationEnabled ?? this.myLocationEnabled,
          currentMarker: currentMarker ?? this.currentMarker);
}
