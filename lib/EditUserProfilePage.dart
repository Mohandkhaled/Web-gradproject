import 'package:flutter/material.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/services/user_services.dart';

class EditUserProfilePage extends StatefulWidget {
  final UserModel user;
  final Function(UserModel) onUserUpdated;

  EditUserProfilePage({required this.user, required this.onUserUpdated});

  @override
  _EditUserProfilePageState createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  late TextEditingController firstnameController;
  late TextEditingController lastnameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController mobileController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    firstnameController = TextEditingController(text: widget.user.firstname);
    lastnameController = TextEditingController(text: widget.user.lastname);
    emailController = TextEditingController(text: widget.user.email);
    addressController = TextEditingController(text: widget.user.address);
    mobileController = TextEditingController(text: widget.user.mobile);
    passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: firstnameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: "Address"),
            ),
            TextFormField(
              controller: mobileController,
              decoration: InputDecoration(labelText: "Mobile"),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _updateUserProfile(context);
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateUserProfile(BuildContext context) async {
    try {
      UserService userService = UserService();

      UserModel updatedUser = UserModel(
        uid: widget.user.uid,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        email: emailController.text,
        address: addressController.text,
        mobile: mobileController.text,
        password: passwordController.text,
      );

      await userService.updateUserDataWithoutPassword(updatedUser);

      // Show Success Dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Successful"),
            content: Text("User profile has been updated successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      // Notify parent widget about the user update
      widget.onUserUpdated(updatedUser);

      // Close the current page
      Navigator.pop(context);
    } catch (error) {
      print("Error updating user profile: $error");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to update user profile. Please check the console for more details."),
      ));
    }
  }
}
