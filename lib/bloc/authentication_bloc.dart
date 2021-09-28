import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grumbler/models/grumbler_user.dart';
import 'package:grumbler/repository/authentication_repository.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final GrumblerUser user;

  AuthenticationAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

abstract class AuthenticationEvent extends Equatable {}

enum AuthProvider {
  google,
  facebook,
  other,
}

class SignInEvent extends AuthenticationEvent {
  final AuthProvider authProvider;
  final String? userName;
  final String? password;

  SignInEvent({required this.authProvider, this.userName, this.password});

  @override
  List<Object?> get props => [authProvider, userName, password];
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _repository;

  AuthenticationBloc(AuthenticationState initialState, this._repository)
      : super(initialState);

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is SignInEvent) {
      yield* _mapSignInEvent(event);
    }
  }

  Stream<AuthenticationState> _mapSignInEvent(SignInEvent event) async* {

    yield AuthenticationLoadingState();

    GrumblerUser grumblerUser;

    switch (event.authProvider) {
      case AuthProvider.google:
        grumblerUser = await _repository.signInWithGoogle();
        break;
      case AuthProvider.facebook:
        grumblerUser = await _repository.signInWithFacebook();
        break;
      case AuthProvider.other:
        grumblerUser =
            const GrumblerUser(name: "name", email: "email", uid: "uid");
        break;
      default:
        grumblerUser =
            const GrumblerUser(name: "name", email: "email", uid: "uid");
        break;
    }

    yield AuthenticationAuthenticated(grumblerUser);
  }
}
