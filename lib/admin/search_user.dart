import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/provides/user_provide.dart';

class FirebaseSearchUserScreen extends StatefulWidget {
  const FirebaseSearchUserScreen({Key? key}) : super(key: key);
  @override
  State<FirebaseSearchUserScreen> createState() =>
      _FirebaseSearchUserScreenState();
}

class _FirebaseSearchUserScreenState extends State<FirebaseSearchUserScreen> {
  List searchResult = [];
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('User')
        .where('firstname', isGreaterThanOrEqualTo: query)
        .get();
    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(1),
        title: const Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
                
                hintText: "Search Here",
                
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
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
             
                          ),
                          Column(
                            children: [
                              Text(searchResult[index]['email']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['firstname']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['lastname']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['address']),
                              SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              Text(searchResult[index]['mobile']),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(1),
                      height: 10,
                      thickness: 3,
                      indent: 25,
                      endIndent: 25,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}