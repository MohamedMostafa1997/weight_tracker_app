import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import 'package:weight_tracker_app/features/auth/model/user.dart';

class AuthRepo {
  final fb.FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepo({
    fb.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : auth = auth ?? fb.FirebaseAuth.instance,
        firestore = firestore ?? FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final userCredential = await auth.signInWithProvider(fb.GoogleAuthProvider());
      final fb.User? user = userCredential.user;
      if (user == null) return null;

      final userModel = User(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        imageUrl: user.photoURL,
        createdAt: DateTime.now(),
      );

      firestore.collection("users").doc(user.uid).set(userModel.toJson(), SetOptions(merge: true));
      return userModel;
    } catch (e) {

      print('Google sign-in failed: $e');
      return null;
    }
  }

  Future<void> signOut() async => await auth.signOut();

 Future<User?> getCurrentUser() async {
    final user = auth.currentUser;
    if (user == null) return null;

    final docSnapshot =
        await firestore.collection('users').doc(user.uid).get();
    if (!docSnapshot.exists) {
      return User(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        imageUrl: user.photoURL,
        createdAt: DateTime.now(),
      );
    }

    return User.fromJson(docSnapshot.data()!);
  }
}
