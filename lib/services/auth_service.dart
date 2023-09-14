import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServer {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser =
          await GoogleSignIn(scopes: ['email']).signIn();

      if (gUser == null) {
        return null;
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }
}
