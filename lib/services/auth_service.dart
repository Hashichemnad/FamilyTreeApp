import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

    // Check if the user is authenticated
  Future<bool> isAuthenticated() async {
    final user = _auth.currentUser;
    return user != null;
  }

  Future<User?> signInWithGoogle() async {
    print('test');
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      print('test1');
      print(googleSignInAccount);
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        print('test2');
        print(googleSignInAuthentication);
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        print('test3');
        print(credential);
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        print('test4');
        print(authResult);
        final User? user = authResult.user;
        return user;
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
    return null;
  }
}
