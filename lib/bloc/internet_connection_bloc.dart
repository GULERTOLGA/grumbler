import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';

abstract class InternetConnectionStateBase extends Equatable {
  @override
  List<Object> get props => [];
}

enum InternetConnection {
  unknown,
  connected,
  none,
}

class InternetConnectionState extends InternetConnectionStateBase {
  final InternetConnection connectionState;

  InternetConnectionState(this.connectionState);

  @override
  List<Object> get props => [connectionState];
}

abstract class InternetConnectionEventBase extends Equatable {
  @override
  List<Object> get props => [];
}

class InternetConnectionCheckEvent extends InternetConnectionEventBase {}

class InternetConnectionStatusChangedEvent extends InternetConnectionEventBase {
  final InternetConnection connectionState;

  InternetConnectionStatusChangedEvent(this.connectionState);

  @override
  List<Object> get props => [connectionState];
}

class InternetConnectionBloc
    extends Bloc<InternetConnectionEventBase, InternetConnectionState> {


  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) return false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  StreamSubscription? subscription;

  InternetConnectionBloc(InternetConnectionState initialState)
      : super(initialState);

  late bool connected;
  @override
  Stream<InternetConnectionState> mapEventToState(
      InternetConnectionEventBase event) async* {
    yield InternetConnectionState(InternetConnection.unknown);
    if (event is InternetConnectionCheckEvent) {
      connected = await checkConnection();
      subscription ??= Connectivity()
            .onConnectivityChanged
            .listen((ConnectivityResult result) async {
          connected = result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi;
          if (connected) connected = await checkConnection();
          add(InternetConnectionStatusChangedEvent(
              connected ? InternetConnection.connected : InternetConnection.none));
        });
      yield InternetConnectionState(
          connected ? InternetConnection.connected : InternetConnection.none);
    }
    if (event is InternetConnectionStatusChangedEvent) {
      yield InternetConnectionState(event.connectionState);
    }
  }
}
