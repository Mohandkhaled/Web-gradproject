import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradproject/controllers/MenuAppController.dart';
import 'package:gradproject/screens/main/main_screen.dart';
import 'package:gradproject/signup.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found");
        Fluttertoast.showToast(
          msg: "No User Found",
          //backgroundColor: mintColors
        );
      } else if (e.code == 'wrong-password') {
        print("wrong password");
        Fluttertoast.showToast(
          msg: "Wrong Password",
          //backgroundColor: mintColors
        );
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var offset = const Offset(0, 3);
    var textStyle = const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          //width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
               // color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: offset,
              ),
            ],
           // color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ignore: prefer_const_constructors
              Text(
                'Welcome!',
                style: textStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                    onPressed: () async {
                                  User? user = await loginUsingEmailPassword(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);
                                  print(user);
                                  if (user != null &&
                                      emailController.text ==
                                          "security@gmail.com") {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: MainScreen(),
      ),));
                                  } else if (user != null) {
                                    // Navigator.of(context).pushReplacement(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             MyHomePage()));
                                  }
                                  // if (formKey.currentState!.validate()) {
                                  //   Fluttertoast.showToast(
                                  //     msg: "Logging in...",
                                  //     // backgroundColor: mintColors
                                  //   );
                                  // }
                                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Handle forgot password functionality here
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Don't have an account?"),
                  const SizedBox(width: 5),
                  TextButton(
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));

                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
