import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInHelper {
  static GoogleSignInHelper _googleSignInHelper = GoogleSignInHelper._private();
  GoogleSignInHelper._private();

  static GoogleSignInHelper get getInstance => _googleSignInHelper;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> googleSignIn() async {
    final user = await _googleSignIn.signIn();

    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<GoogleSignInAccount?> googleSignOut() async {
    final user = await _googleSignIn.signOut();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
