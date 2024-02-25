import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradproject/constants.dart';
import 'package:gradproject/controllers/MenuAppController.dart';
import 'package:gradproject/login.dart';
import 'package:gradproject/login_page.dart';
import 'package:gradproject/reg.dart';
import 'package:gradproject/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradproject/signup.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const FirebaseOptions(
      apiKey: "AIzaSyDasE3LMxheAKkNxPLh9LNy0h3qN0awQIY",
       appId: "1:503039862204:web:f103eceb6dc9e41a25f7b9", 
       messagingSenderId:  "503039862204",
        projectId: "insider-web-a9a12")
  );
  runApp(
    MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child:
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MyAppp(),),
    );
  }
}
class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,

                    ),
                    
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("BackSlash Flutter provides extraordinary flutter tutorials. Do Subscribe! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,

                  ),)
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/welcome.png")
                  )
                ),
              ),

              Column(
                children: <Widget>[
                 // the login button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                    },
                    // defining the shape
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                  ),
      //              MaterialButton(
      //               minWidth: double.infinity,
      //               height: 60,
      //               onPressed: () {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context) => MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(
      //       create: (context) => MenuAppController(),
      //     ),
      //   ],
      //   child: MainScreen(),
      // ),));

      //               },
      //               // defining the shape
      //               shape: RoundedRectangleBorder(
      //                 side: const BorderSide(
      //                   color: Colors.black
      //                 ),
      //                 borderRadius: BorderRadius.circular(50)
      //               ),
      //               child: const Text(
      //                 "Dashboard",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w600,
      //                   fontSize: 18
      //                 ),
      //               ),
      //             ),
                  
                  // creating the signup button
                  const SizedBox(height:20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: (){
                      
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));

                    },
                    color: const Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                  )

                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}