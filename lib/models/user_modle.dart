class UserModel {
  String uid; // New field to store user UID
  String firstname;
  String lastname;
  String email;
  String address;
  String mobile;
  String password;

  UserModel({
    required this.uid, // Updated constructor to include UID
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.mobile,
    required this.password,
  });

  // Factory method to create UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      firstname: data['firstname'] ?? '',  // Updated key to 'firstName'
      lastname: data['lastname'] ?? '',    // Updated key to 'lastName'
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      mobile: data['mobile'] ?? '',
      password: data['password'] ?? '',
    );
  }

  // Method to convert UserModel to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'address': address,
      'mobile': mobile,
      'password': password,
    };
  }
}