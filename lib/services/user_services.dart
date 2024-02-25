import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradproject/models/user_modle.dart';

class UserService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('User');

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    QuerySnapshot snapshot = await _usersCollectionReference.get();
    snapshot.docs.forEach((document) {
      UserModel user = UserModel(
       
        firstName: document.data().toString().contains('firstname')
            ? document.get('firstname')
            : '',
        lastName: document.data().toString().contains('lastname')
            ? document.get('lastname')
            : '',
        email: document.data().toString().contains('email')
            ? document.get('email')
            : '',
        address: document.data().toString().contains('address')
            ? document.get('address')
            : '',
        mobile: document.data().toString().contains('mobile')
            ? document.get('mobile')
            : '',
        password: document.data().toString().contains('password')
            ? document.get('password')
            : '',   
      );
      users.add(user);
    });

    return users;
  }
}