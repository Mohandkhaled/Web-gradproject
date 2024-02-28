import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Profile'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      "assets/images/profile_pic.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Profile Heading',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'Profile Subheading',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuFlutter(
                  title: "Settings",
                  icon: Icons.menu_book,
                  onPress: () {},
                ),
                ProfileMenuFlutter(
                  title: "Billing Details",
                  icon: Icons.wallet_membership,
                  onPress: () {},
                ),
                ProfileMenuFlutter(
                  title: "Security Analyst",
                  icon: Icons.verified_user,
                  onPress: () {},
                ),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuFlutter(
                  title: "Information",
                  icon: Icons.info,
                  onPress: () {},
                ),
                ProfileMenuFlutter(
                  title: "Logout",
                  icon: Icons.exit_to_app,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuFlutter extends StatelessWidget {
  const ProfileMenuFlutter({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: Theme.of(context).primaryColor),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.mediation,
                size: 18.0,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
