// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';
import 'package:my_shop_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final TextEditingController phonenumcontroller = TextEditingController();

  Country selectedcountry = Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    example: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
  );
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    phonenumcontroller.selection = TextSelection.fromPosition(
        TextPosition(offset: phonenumcontroller.text.length));
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: mediaQuery.viewPadding.vertical + 25,
                horizontal: mediaQuery.viewPadding.horizontal + 35,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Enter your Phone Number',
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
                    "Add your phone number ,We'll send you the verfication code",
                    style: TextStyle(
                      fontSize: mediaQuery.textScaleFactor * 18,
                      color: colors.mygrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.02,
                  ),
                  TextFormField(
                    cursorColor: colors.gradient1purple,
                    controller: phonenumcontroller,
                    onChanged: (value) {
                      setState(() {
                        phonenumcontroller.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: colors.myblack,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: colors.myblack,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: colors.myblack,
                        ),
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(16.0),
                        child: InkWell(
                          onTap: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                onSelect: (value) {
                                  setState(() {
                                    selectedcountry = value;
                                  });
                                });
                          },
                          child: Text(
                            "${selectedcountry.flagEmoji} +${selectedcountry.phoneCode}",
                            style: TextStyle(
                              fontSize: 18,
                              color: colors.myblack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      suffixIcon: phonenumcontroller.text.length > 9
                          ? Container(
                              height: mediaQuery.size.height * 0.02,
                              width: mediaQuery.size.width * 0.02,
                              margin: EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: colors.mywhite,
                                size: 18,
                              ),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.08,
                  ),
                  InkWell(
                    onTap: () {
                      sendPhonenumber();
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
                            'Login',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhonenumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phonenumber = phonenumcontroller.text.trim();
    ap.signinWithPhone(context, "+${selectedcountry.phoneCode}$phonenumber");
  }
}
