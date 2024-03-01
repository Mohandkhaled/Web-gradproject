// Updated ViewUsersPage
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/EditUserProfilePage.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/services/user_services.dart';

final usersStreamProvider = StreamProvider<List<UserModel>>((ref) {
  UserService userService = UserService();
  return userService.getUsersStream();
});

class ViewUsersPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    final users = ref.watch(usersStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              //context: context, delegate:
              // Navigator.pushNamed(context, 'search_users');
            },
            icon: const Icon(Icons.search),
          ),
          // Toggle Dark Mode button
          IconButton(
            onPressed: () {
              final Brightness newBrightness =
                  isDarkMode ? Brightness.light : Brightness.dark;
              ThemeMode newThemeMode =
                  newBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
              var themeModeProvider;
              ProviderScope.containerOf(context).read(themeModeProvider.notifier).setThemeMode(newThemeMode);
            },
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: SafeArea(
        child: users.when(
          data: (value) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                UserModel user = value[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                      ),
                    ),
                    title: Text(
                      "${user.firstname} ${user.lastname}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.firstname),
                        Text(user.lastname),
                        Text(user.email),
                        Text(user.address),
                        Text(user.mobile),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditUserProfilePage(user: user, onUserUpdated: (UserModel updatedUser) {
                                  // Handle user update if needed
                                }),
                              ),
                            );
                          },
                          child: Text('Edit'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            _removeUser(context, user, ref);
                          },
                          child: Text('Remove'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
        ),
      ),
    );
  }

  void _removeUser(BuildContext context, UserModel user, WidgetRef ref) async {
    try {
      UserService userService = UserService();
      await userService.removeUser(user);

      // Update the UI by refetching the user list
      ref.refresh(usersStreamProvider);

      // Show Success Dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Remove Successful"),
            content: Text("User has been removed successfully."),
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
    } catch (error) {
      print("Error removing user: $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to remove user. Please check the console for more details."),
      ));
    }
  }
}
