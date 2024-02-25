import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/provides/user_provide.dart';

class ViewUsersPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(100, 25, 150, 0),
          title: Text("Users List"),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(255, 0, 25, 1),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                //context: context, delegate:
                Navigator.pushNamed(context, 'search_users');
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer(
            builder: (context, watch, _) {
              final users = ref.watch(usersProvider);
              return users.when(
                data: (value) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      UserModel user = value[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      // shape: BoxShape.circle,
                                      // image: DecorationImage(
                                      //     fit: BoxFit.cover,
                                      //     image: NetworkImage(user.userImage))
                                      ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(255, 0, 25, 1)),
                                        user.email),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.firstName),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.lastName),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.address),
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(user.mobile),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(255, 0, 25, 1),
                            height: 10,
                            thickness: 3,
                            indent: 25,
                            endIndent: 25,
                          )
                        ],
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text(error.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}