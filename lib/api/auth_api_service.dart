import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth    _auth   = FirebaseAuth.instance;
  final CollectionReference _usersRef =
  FirebaseFirestore.instance.collection('users');

  /// Register with email & password, then store additional user data.
  Future<User> registerWithEmail({
    required String name,
    required String email,
    required String phone,
    required int age,
    required String password,
  }) async {
    // 1) Create the auth account
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = cred.user!.uid;

    // 2) Build your Firestore UserModel
    final newUser = UserModel(
      id: uid,
      name: name,
      email: email,
      phone: phone,
      age: age,
      labHistory: {},
    );

    // 3) Store in Firestore under /users/{uid}
    await _usersRef.doc(uid).set(newUser.toMap());

    return cred.user!;
  }
}
