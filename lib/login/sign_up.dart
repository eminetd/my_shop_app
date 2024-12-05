// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, non_constant_identifier_names, body_might_complete_normally_catch_error

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop_app/color/colors.dart';
import 'package:my_shop_app/homescreen.dart';
import 'package:my_shop_app/model/user_model.dart';

class SignUpbyEmail extends StatefulWidget {
  const SignUpbyEmail({super.key});

  @override
  State<SignUpbyEmail> createState() => _SignUpbyEmailState();
}

class _SignUpbyEmailState extends State<SignUpbyEmail> {
  final _formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  //editing controllers
  final fullnamecontroller = TextEditingController();
  final pincodecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final reEnterpasswordcontroller = TextEditingController();
  DateTime date = DateTime(2023, 4, 30);
  File? image;
  Future pickimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final fullnamefield = TextFormField(
      autofocus: false,
      controller: fullnamecontroller,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^[a-z A-Z]');
        if (value!.isEmpty) {
          return ("Full Name is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter name");
        }
        return null;
      },
      onSaved: (value) {
        fullnamecontroller.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
        ),
        contentPadding: EdgeInsets.fromLTRB(
          mediaQuery.viewPadding.left + 20,
          mediaQuery.viewPadding.top + 15,
          mediaQuery.viewPadding.right + 20,
          mediaQuery.viewPadding.bottom + 15,
        ),
        hintText: 'Enter Full Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final pincodefield = TextFormField(
      autofocus: false,
      controller: pincodecontroller,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        pincodecontroller.text = value!;
      },
      validator: (value) {
        RegExp regex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-6]+$');
        if (value!.isEmpty) {
          return ("Pincode is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter Pincode");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.place,
        ),
        contentPadding: EdgeInsets.fromLTRB(
          mediaQuery.viewPadding.left + 20,
          mediaQuery.viewPadding.top + 15,
          mediaQuery.viewPadding.right + 20,
          mediaQuery.viewPadding.bottom + 15,
        ),
        hintText: 'Enter your Pincode',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final emailfield = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailcontroller.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please enter valid mail");
        }
        return null;
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
          prefixIcon: Icon(
            Icons.vpn_key,
          ),
          contentPadding: EdgeInsets.fromLTRB(
            mediaQuery.viewPadding.left + 20,
            mediaQuery.viewPadding.top + 15,
            mediaQuery.viewPadding.right + 20,
            mediaQuery.viewPadding.bottom + 15,
          ),
          hintText: 'Enter your password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    //password fields
    final reEnterpasswordfield = TextFormField(
      autofocus: false,
      controller: reEnterpasswordcontroller,
      validator: (value) {
        if (reEnterpasswordcontroller.text != passwordcontroller.text) {
          return ("password Don't match");
        }
        return null;
      },
      onSaved: (value) {
        reEnterpasswordcontroller.text = value!;
      },
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(
          mediaQuery.viewPadding.left + 20,
          mediaQuery.viewPadding.top + 15,
          mediaQuery.viewPadding.right + 20,
          mediaQuery.viewPadding.bottom + 15,
        ),
        hintText: 'Re - Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final SignUpbutton = Material(
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
          signUp(emailcontroller.text, passwordcontroller.text);
        },
        child: Text(
          'SignUp',
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
      appBar: AppBar(
        backgroundColor: colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colors.myblack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: mediaQuery.viewInsets.top + 10,
                    ),
                    child: SizedBox(
                      height: mediaQuery.size.height * 0.20,
                      width: mediaQuery.size.width * 0.4,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: mediaQuery.size.height * 0.18,
                            width: mediaQuery.size.width * 0.4,
                            child: Container(
                              height: mediaQuery.size.height * 0.13,
                              width: mediaQuery.size.width * 0.5,
                              decoration: BoxDecoration(
                                color: colors.mygrey,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: image != null
                                    ? Image.file(
                                        image!,
                                        width: mediaQuery.size.width * 0.25,
                                        height: mediaQuery.size.height * 0.40,
                                        fit: BoxFit.cover,
                                      )
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Icon(
                                          Icons.person_add,
                                          color: colors.myblack,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            left: 100,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      content: SizedBox(
                                        height: mediaQuery.size.height * 0.3,
                                        width: mediaQuery.size.width * 0.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    pickimage(
                                                      ImageSource.gallery,
                                                    );
                                                  },
                                                  child: Container(
                                                    height:
                                                        mediaQuery.size.height *
                                                            0.05,
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.40,
                                                    decoration: BoxDecoration(
                                                      color: colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          'Select from Gallery',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                colors.mywhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    pickimage(
                                                        ImageSource.camera);
                                                  },
                                                  child: Container(
                                                    height:
                                                        mediaQuery.size.height *
                                                            0.05,
                                                    width:
                                                        mediaQuery.size.width *
                                                            0.40,
                                                    decoration: BoxDecoration(
                                                      color: colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          'Select from Camera',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color:
                                                                colors.mywhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: mediaQuery.size.height * 0.06,
                                width: mediaQuery.size.width * 0.15,
                                decoration: BoxDecoration(
                                  color: colors.orange,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: colors.mygrey,
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: colors.mywhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  fullnamefield,
                  SizedBox(
                    height: mediaQuery.size.height * 0.03,
                  ),
                  Container(
                    height: mediaQuery.size.height * 0.07,
                    width: mediaQuery.size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: colors.mygrey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: mediaQuery.viewInsets.right + 30,
                          ),
                          child: AutoSizeText(
                            '${date.year}/${date.month}/${date.day}',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: mediaQuery.viewInsets.left + 10,
                          ),
                          child: InkWell(
                            onTap: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );
                              if (newDate == null) return;

                              setState(() {
                                date = newDate;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.03,
                  ),
                  pincodefield,
                  SizedBox(
                    height: mediaQuery.size.height * 0.03,
                  ),
                  emailfield,
                  SizedBox(
                    height: mediaQuery.size.height * 0.03,
                  ),
                  passwordfield,
                  SizedBox(
                    height: mediaQuery.size.height * 0.03,
                  ),
                  reEnterpasswordfield,
                  SizedBox(
                    height: mediaQuery.size.height * 0.03,
                  ),
                  SignUpbutton,
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = fullnamecontroller.text;
    userModel.pincode = pincodecontroller.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created succesfully ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }
}
