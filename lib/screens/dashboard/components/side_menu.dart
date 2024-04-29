import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradproject/login_page.dart';
import 'package:gradproject/profile_screen.dart';
import 'package:gradproject/screens/dashboard/components/detect_anomalies_page.dart';
import 'package:gradproject/viewuserprofile.dart';
import 'package:gradproject/parsing_results.dart';
class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo3.PNG"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () { },
          ),
        
          DrawerListTile(
            title: "Active Users",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  ProfilePage()),
  );},
          ),

          
          DrawerListTile(
            title: "Edit User",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  ViewUsersPage()),
  );},
          ),
          DrawerListTile(
            title: "Detect Anomalies",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => detectanomaliespage()),
  );},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),          
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}