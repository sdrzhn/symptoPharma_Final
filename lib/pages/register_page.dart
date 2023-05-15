import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:symptopharm/pages/login_page.dart';
import 'package:symptopharm/theme.dart';
import 'package:symptopharm/widget/button_primary.dart';
import 'package:symptopharm/widget/general_logo_space.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPages extends StatefulWidget {
  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  registerSubmit() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Registration successful, store additional user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'full_name': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      });
      // Registration successful, do something
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Information"),
          content: Text("Registration successful"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPages()),
                    (route) => false);
              },
              child: Text("OK"),
            )
          ],
        ),
      );
    } catch (e) {
      // Registration failed, display error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Information"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: GeneralLogoSpace(
              child: Column(children: [
                SizedBox(
                  height: 1,
                ),
              ]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "REGISTER",
                  style: regulerTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Register new your account",
                    style: regulerTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor)),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                //2
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                //3
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Home Address',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                //4
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          spreadRadius: 0)
                    ],
                    color: whiteColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _secureText
                            ? Icon(
                                Icons.visibility_off,
                                color: Color(0xffADADAD),
                                size: 22,
                              )
                            : Icon(
                                Icons.visibility,
                                color: Color(0xff6ebe81),
                                size: 22,
                              ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: lightTextStyle.copyWith(
                          fontSize: 15, color: greyLightColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      text: "REGISTER",
                      onTap: () {
                        if (fullNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            phoneController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Warning !!"),
                                    content: Text("Please, enter the fields"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  ));
                        } else {
                          registerSubmit();
                        }
                      },
                    )),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPages()),
                            (route) => false);
                      },
                      child: Text(
                        "Login now",
                        style: boldTextStyle.copyWith(
                            color: greenColor, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
