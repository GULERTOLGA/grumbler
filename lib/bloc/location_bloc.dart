import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:location/location.dart';

abstract class LocationEvent {}

enum LocationErrorStatus {
  serviceNotEnabled,
  permissionDenied,
}

class LocationStartedEvent extends LocationEvent {}

class LocationChangedEvent extends LocationEvent {
  final LocationData position;

  LocationChangedEvent({required this.position});
}

class LocationDataRetrievedEvent extends LocationEvent {
  final LocationData position;

  LocationDataRetrievedEvent({required this.position});
}

abstract class LocationState {}

class LocationInitialState extends LocationState {}

class LocationLoadInProgressState extends LocationState {}

class LocationDataChangedState extends LocationState {
  final LocationData position;

  LocationDataChangedState({required this.position});
}

class LocationLoadErrorState extends LocationState {
  final LocationErrorStatus status;

  LocationLoadErrorState(this.status);
}

class LocationLoadSuccessState extends LocationState {
  final LocationData position;

  LocationLoadSuccessState({required this.position});
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Location _location = Location();

  LocationBloc(LocationState initialState) : super(initialState);

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is LocationStartedEvent) {
      yield* _mapLocationStartedEvent();
    }

    if (event is LocationChangedEvent) {
      yield LocationDataChangedState(position: event.position);
    }
    if (event is LocationDataRetrievedEvent) {
      yield LocationLoadSuccessState(position: event.position);
    }
  }

  Stream<LocationState> _mapLocationStartedEvent() async* {
    yield LocationLoadInProgressState();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        yield LocationLoadErrorState(LocationErrorStatus.serviceNotEnabled);
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        yield LocationLoadErrorState(LocationErrorStatus.permissionDenied);
      }
    }

    _locationData = await _location.getLocation();

    _location.onLocationChanged.listen((LocationData currentLocation) {
      add(LocationChangedEvent(position: currentLocation));
    });

    add(LocationDataRetrievedEvent(position: _locationData));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
