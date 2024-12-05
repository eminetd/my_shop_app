// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';
import 'package:my_shop_app/homescreen.dart';
import 'package:my_shop_app/provider/auth_provider.dart';
import 'package:my_shop_app/utils/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String verficationId;
  const OtpScreen({super.key, required this.verficationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpcode;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isloading =
        Provider.of<AuthProvider>(context, listen: true).isloading;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: mediaQuery.viewPadding.vertical + 25,
            horizontal: mediaQuery.viewPadding.horizontal + 35,
          ),
          child: isloading == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: colors.myblack,
                ))
              : Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Verification',
                            style: TextStyle(
                              fontSize: mediaQuery.textScaleFactor * 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.02,
                      ),
                      Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                          fontSize: mediaQuery.textScaleFactor * 18,
                          color: colors.mygrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.02,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.myblack),
                          ),
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpcode = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          print(otpcode);
                          if (otpcode != null) {
                            verifyOtp(context, otpcode!);
                          } else {
                            showSnackbar(context, "Enter 6 - digit code");
                          }
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
                                'Verify',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: colors.mywhite,
                                  fontSize: mediaQuery.textScaleFactor * 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.03,
                      ),
                      Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: mediaQuery.textScaleFactor * 18,
                          color: colors.mygrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: mediaQuery.size.height * 0.03,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: mediaQuery.textScaleFactor * 20,
                            color: colors.myblack,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // verify otp

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyotp(
      context: context,
      verficationId: widget.verficationId,
      userOtp: userOtp,
      onsucess: () {
        //check existing user
        ap.checkExistingUser().then((value) async {
          if (value == true) {
            //user exist in app
          } else {
            // new user
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          }
        });
      },
    );
  }
}
