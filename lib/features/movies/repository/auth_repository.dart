import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/features/movies/model/user_model.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<void> signIn({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> signUp({required UserModel user, required String password}) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: user.email.trim(),
      password: password,
    );
    final firebaseUser = credential.user!;
    await firebaseUser.updateDisplayName(user.name);
    await _users
        .doc(firebaseUser.uid)
        .set(user.copyWith(uid: firebaseUser.uid).toMap());
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'sign_in_aborted',
        message: 'Google sign-in was cancelled.',
      );
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final firebaseUser = userCredential.user;

    if (firebaseUser != null) {
      final userDoc = await _users.doc(firebaseUser.uid).get();
      if (!userDoc.exists) {
        await _users.doc(firebaseUser.uid).set(
          UserModel(
            uid: firebaseUser.uid,
            name: firebaseUser.displayName ?? googleUser.displayName ?? '',
            email: firebaseUser.email ?? googleUser.email,
            phone: firebaseUser.phoneNumber ?? '',
            avatar: 'assets/images/avater1.png',
          ).toMap(),
        );
      }
    }
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  bool get isLoggedIn => _auth.currentUser != null;
}