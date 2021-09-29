import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:grumbler/models/address_item.dart';
import 'package:grumbler/repository/geocoding_repository.dart';

abstract class GeocodingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeocodingInitialState extends GeocodingState {}

class GeocodingLoadingState extends GeocodingState {}

class GeocodingErrorState extends GeocodingState {}

class GeocodingLoadedState extends GeocodingState {
  final AddressItem? addressItem;

  GeocodingLoadedState(this.addressItem);

  @override
  List<Object?> get props => [addressItem];
}

abstract class GeocodingEvent extends Equatable {}

class GeocodingLoadEvent extends GeocodingEvent {
  final double latitude;
  final double longitude;

  GeocodingLoadEvent(this.latitude, this.longitude);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GeocodingBloc extends Bloc<GeocodingEvent, GeocodingState> {
  final IGeocodingRepository _repository;

  GeocodingBloc(GeocodingState initialState, this._repository)
      : super(initialState);

  @override
  Stream<GeocodingState> mapEventToState(GeocodingEvent event) async* {
    if (event is GeocodingLoadEvent) {
      yield GeocodingLoadingState();

      AddressItem? addressItem;
      try {
        addressItem =
            await _repository.fromCoordinates(event.latitude, event.longitude);
      } on PlatformException {
        yield GeocodingErrorState();
      }
      yield GeocodingLoadedState(addressItem);
    }
  }
}
