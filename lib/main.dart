import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grumbler/bloc/location_bloc.dart';
import 'package:grumbler/networking/authentication_api_client.dart';
import 'package:grumbler/repository/authentication_repository.dart';
import 'package:grumbler/repository/geocoding_repository.dart';
import 'package:grumbler/view/screens/map_screen.dart';
import 'package:grumbler/view/screens/sign_in_screen.dart';
import 'package:grumbler/view/theme.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/internet_connection_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  //TODO: ios implementation of only portrait orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const GrumblerMainApp());
}

class GrumblerMainApp extends StatelessWidget {
  const GrumblerMainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
            create: (ctx) =>
                AuthenticationRepository(FirebaseAuthenticationApiClient()),
          ),
          RepositoryProvider<IGeocodingRepository>(
            create: (ctx) => GoogleGeoCodingRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
                create: (_) => AuthenticationBloc(AuthenticationInitialState(),
                    RepositoryProvider.of<AuthenticationRepository>(_))),
            BlocProvider<LocationBloc>(
                create: (_) => LocationBloc(LocationInitialState())
                  ..add(LocationStartedEvent())),
            BlocProvider<InternetConnectionBloc>(
              create: (context) {
                return InternetConnectionBloc(
                    InternetConnectionState(InternetConnection.unknown))
                  ..add(InternetConnectionCheckEvent());
              },
            ),
          ],
          child: MaterialApp(
            theme: defaultTheme(),
            title: 'Grumbler',
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (ctx, state) {
              if (state is AuthenticationUnauthenticated) {
                return const SignInScreen();
              }
              if (state is AuthenticationAuthenticated) {
                return const MapScreen();
              }
              return const SignInScreen();
            }),
          ),
        ));
  }
}
