import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseSearchUserScreen extends StatefulWidget {
  const FirebaseSearchUserScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseSearchUserScreen> createState() =>
      _FirebaseSearchUserScreenState();
}

class _FirebaseSearchUserScreenState extends State<FirebaseSearchUserScreen> {
  List<Map<String, dynamic>> searchResult = [];

  void searchFromFirebase(String query) async {
    query = query.toLowerCase(); // Convert query to lowercase
    final result = await FirebaseFirestore.instance
        .collection('User')
        .where('firstname', isEqualTo: query)
        .get();
    setState(() {
      searchResult = result.docs.map((e) => e.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set your desired color
        title: Text("Search"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0), // Set your desired color
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search by name",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                searchFromFirebase(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      // You can display user images here if available
                      backgroundColor: Colors.blue,
                    ),
                    title: Text(
                      '${searchResult[index]['firstname']} ${searchResult[index]['lastname']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${searchResult[index]['email']}'),
                        Text('Address: ${searchResult[index]['address']}'),
                        Text('Mobile: ${searchResult[index]['mobile']}'),
                      ],
                    ),
                    onTap: () {
                      // Handle tap on the user item
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
