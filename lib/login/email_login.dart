// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, body_might_complete_normally_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop_app/color/colors.dart';
import 'package:my_shop_app/homescreen.dart';
import 'package:my_shop_app/login/sign_up.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //emailfield
    final emailfield = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter valid mail");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
          ),
          contentPadding: EdgeInsets.fromLTRB(
            mediaQuery.viewPadding.left + 20,
            mediaQuery.viewPadding.top + 15,
            mediaQuery.viewPadding.right + 20,
            mediaQuery.viewPadding.bottom + 15,
          ),
          hintText: 'Enter mail id',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    //password fields
    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordcontroller,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password Required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter password Min 6 character");
        }
        return null;
      },
      onSaved: (value) {
        passwordcontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(
          mediaQuery.viewPadding.left + 20,
          mediaQuery.viewPadding.top + 15,
          mediaQuery.viewPadding.right + 20,
          mediaQuery.viewPadding.bottom + 15,
        ),
        hintText: 'Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final loginbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colors.myblack,
      child: MaterialButton(
        // padding: EdgeInsets.fromLTRB(
        //   mediaQuery.viewPadding.left + 20,
        //   mediaQuery.viewPadding.top + 15,
        //   mediaQuery.viewPadding.right + 20,
        //   mediaQuery.viewPadding.bottom + 15,
        // ),
        minWidth: mediaQuery.size.width * 0.8,
        onPressed: () {
          signIn(emailController.text, passwordcontroller.text);
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: colors.mywhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: mediaQuery.size.height * 0.1,
                  ),
                  emailfield,
                  SizedBox(
                    height: mediaQuery.size.height * 0.05,
                  ),
                  passwordfield,
                  SizedBox(
                    height: mediaQuery.size.height * 0.05,
                  ),
                  loginbutton,
                  SizedBox(
                    height: mediaQuery.size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpbyEmail(),
                            ),
                          );
                        },
                        child: Text(
                          ' SignUp',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: colors.gradient1purple,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  //login

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successfull"),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
      return null;
    }
  }
}
