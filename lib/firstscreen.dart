// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';
import 'package:my_shop_app/login/email_login.dart';
import 'package:my_shop_app/login/phonelogin.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.5,
              ),
              Text(
                "Let's Get started",
                style: TextStyle(
                  fontSize: mediaQuery.textScaleFactor * 28,
                ),
              ),
              Text(
                "Choose your login Option",
                style: TextStyle(
                  fontSize: mediaQuery.textScaleFactor * 25,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: mediaQuery.viewPadding.top + 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneLogin()));
                      },
                      child: Container(
                        height: mediaQuery.size.height * 0.05,
                        width: mediaQuery.size.width * 0.9,
                        decoration: BoxDecoration(
                          color: colors.myblack,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: AutoSizeText(
                              'Phone',
                              style: TextStyle(
                                color: colors.mywhite,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: mediaQuery.viewPadding.top + 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailLogin()));
                      },
                      child: Container(
                        height: mediaQuery.size.height * 0.05,
                        width: mediaQuery.size.width * 0.9,
                        decoration: BoxDecoration(
                          color: colors.myblack,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: AutoSizeText(
                              'Email',
                              style: TextStyle(
                                color: colors.mywhite,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
