import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Future<FirebaseUser> getSignedInAccount() async {
//  FirebaseUser user = await FirebaseAuth.instance.currentUser();
//  assert(user != null);
//  assert(!user.isAnonymous);
//  return user != null ? user : null;
//}

//Future<void> signOutAccount() async {
//  await FirebaseAuth.instance.signOut();
//}

Future <UserCredential>signIntoFirebase(
    GoogleSignInAccount googleSignInAccount) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await _auth.signInWithCredential(credential);
}
