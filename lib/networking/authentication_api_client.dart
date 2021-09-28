import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grumbler/models/grumbler_user.dart';

abstract class IAuthenticationApiClient {
  Future<GrumblerUser> loginWithUsernameAndPassword(
      String userName, String password);

  Future<GrumblerUser> signInWithFacebook();

  Future<GrumblerUser> signInWithGoogle();

  Future<GrumblerUser> signInWithApple();

  Future<void> signOut();
}


class FirebaseAuthenticationApiClient implements IAuthenticationApiClient {
  @override
  Future<GrumblerUser> loginWithUsernameAndPassword(
      String userName, String password) {
    // TODO: implement loginWithUsernameAndPassword
    throw UnimplementedError();
  }

  @override
  Future<GrumblerUser> signInWithApple() {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<GrumblerUser> signInWithFacebook() async{
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);

    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    GrumblerUser grumblerUser = _createUser(userCredential);

    return grumblerUser;
  }

  @override
  Future<GrumblerUser> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    GrumblerUser grumblerUser = _createUser(userCredential);

    return grumblerUser;
  }

  GrumblerUser _createUser(UserCredential userCredential) {
     GrumblerUser grumblerUser = GrumblerUser(
        name: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? "",
        uid: userCredential.user!.uid);
    return grumblerUser;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
