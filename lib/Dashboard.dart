// dashboard.dart

import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
   
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('View User'),
              onTap: () {
                // TODO: Implement the action for View User
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewUserPage()),
                );
              },
            ),
            ListTile(
              title: Text('Active User'),
              onTap: () {
                // TODO: Implement the action for Active User
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActiveUserPage()),
                );
              },
            ),
            ListTile(
              title: Text('Alert'),
              onTap: () {
                // TODO: Implement the action for Alert
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlertPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ViewUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View User'),
      ),
   
    );
  }
}

class ActiveUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active User'),
      ),
    
    );
  }
}

class AlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert'),
      ),
     
    );
  }
}
