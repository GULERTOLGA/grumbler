import 'package:grumbler/models/grumbler_user.dart';
import 'package:grumbler/networking/authentication_api_client.dart';

class AuthenticationRepository {

  final IAuthenticationApiClient _client;

  AuthenticationRepository(this._client);

  Future<GrumblerUser> loginWithUsernameAndPassword(String userName,String password) {
    // TODO: implement loginWithUsernameAndPassword
    throw UnimplementedError();
  }

  Future<GrumblerUser> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  Future<GrumblerUser> signInWithFacebook() {
   return _client.signInWithFacebook();
  }

  Future<GrumblerUser> signInWithGoogle() {
    return _client.signInWithGoogle();
  }

  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

}