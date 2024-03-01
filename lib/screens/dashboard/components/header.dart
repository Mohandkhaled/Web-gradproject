import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/admin/search_user.dart';
import 'package:gradproject/controllers/MenuAppController.dart';
import 'package:gradproject/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradproject/models/user_modle.dart';
import 'package:gradproject/provides/user_provide.dart';

import '../../../constants.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);  
  @override
 State<Header> createState()=> 
 _Header();} 
  
class _Header extends State<Header>{
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
  
 
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Insiders"),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) { 
    
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FirebaseSearchUserScreen()),
  );},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}

// class FirebaseSearchUserScreen extends StatefulWidget {
//   const FirebaseSearchUserScreen({Key? key}) : super(key: key);
//   @override
//   State<FirebaseSearchUserScreen> createState() =>
//       _FirebaseSearchUserScreenState();
// }

// class _FirebaseSearchUserScreenState extends State<FirebaseSearchUserScreen> {
//   List searchResult = [];
//   void searchFromFirebase(String query) async {
//     final result = await FirebaseFirestore.instance
//         .collection('User')
//         .where('firstname', isGreaterThanOrEqualTo: query)
//         .get();
//     setState(() {
//       searchResult = result.docs.map((e) => e.data()).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(1),
//         title: const Text("Search"),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Search Here",
//               ),
//               onChanged: (query) {
//                 searchFromFirebase(query);
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchResult.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 80,
//                             height: 80,
             
//                           ),
//                           Column(
//                             children: [
//                               Text(searchResult[index]['email']),
//                               SizedBox(
//                                 height: 10,
//                                 width: 10,
//                               ),
//                               Text(searchResult[index]['firstname']),
//                               SizedBox(
//                                 height: 10,
//                                 width: 10,
//                               ),
//                               Text(searchResult[index]['lastname']),
//                               SizedBox(
//                                 height: 10,
//                                 width: 10,
//                               ),
//                               Text(searchResult[index]['address']),
//                               SizedBox(
//                                 height: 10,
//                                 width: 10,
//                               ),
//                               Text(searchResult[index]['mobile']),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Divider(
//                       color: Color(1),
//                       height: 10,
//                       thickness: 3,
//                       indent: 25,
//                       endIndent: 25,
//                     )
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }