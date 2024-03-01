// Updated UserService
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/models/user_modle.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUsersStream() {
    return _firestore.collection('User').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> createUser(UserModel user) async {
    try {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      await _firestore.collection('User').doc(uid).set(user.toFirestore());
    } catch (error) {
      print("Error creating user: $error");
      throw error;
    }
  }

  Future<UserModel?> getUserById(String uid) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('User').doc(uid).get();
      if (snapshot.exists) {
        return UserModel.fromFirestore(snapshot.data() as Map<String, dynamic>, uid);
      } else {
        return null;
      }
    } catch (error) {
      print("Error retrieving user: $error");
      throw error;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('User').get();
      List<UserModel> users = snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      return users;
    } catch (error) {
      print("Error retrieving users: $error");
      throw error;
    }
  }

  Future<void> updateUserDataWithoutPassword(UserModel user) async {
    try {
      await _firestore.collection('User').doc(user.uid).update({
        'firstname': user.firstname,
        'lastname': user.lastname,
        'email': user.email,
        'address': user.address,
        'mobile': user.mobile,
      });
    } catch (error) {
      print("Error updating user data without password: $error");
      throw error;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('User').doc(user.uid).update(user.toFirestore());
    } catch (error) {
      print("Error updating user: $error");
      throw error;
    }
  }

  Future<void> removeUser(UserModel user) async {
    try {
      await _firestore.collection('User').doc(user.uid).delete();
    } catch (error) {
      print("Error removing user: $error");
      throw error;
    }
  }
}
