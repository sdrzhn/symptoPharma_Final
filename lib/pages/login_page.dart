import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:symptopharm/network/api/url_api.dart';
import 'package:symptopharm/pages/register_page.dart';
import '../main_page.dart';
import '../theme.dart';
import '../widget/button_primary.dart';
import '../widget/general_logo_space.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

    bool _secureText = true;
  showHide(){
    setState(() {
      _secureText = !_secureText;
    });
  }

  submitLogin() async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
   final response = await http.post(urlLogin, body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Information"),
          content: Text(message),
          actions: [TextButton(onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainPages()), (route) => false);
            }, child: Text("OK"))],
        ));
        setState(() {});
    } else{
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Information"),
          content: Text(message),
          actions: [TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("OK"))],
        ));
    }
    setState(() {});

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: GeneralLogoSpace(child: Column(
          children: [
            SizedBox(
              height: 1,
            ),
        ]),),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text("LOGIN", style: regulerTextStyle.copyWith(fontSize: 25),),
                SizedBox(height: 8,),
                Text("Login into your account", style: regulerTextStyle.copyWith(fontSize: 15, color: greyLightColor)),
                SizedBox(height: 24,),
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
                    color: whiteColor,),
                    width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Address',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor),),
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
                    color: whiteColor,),
                    width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: showHide,
                        icon: _secureText ? 
                        Icon(Icons.visibility_off, color: Color(0xffADADAD), size: 22,) : 
                        Icon(Icons.visibility, color: Color(0xff6ebe81), size: 22,),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor),),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "LOGIN", 
                    onTap: (){
                      if (emailController.text.isEmpty ||  
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
                                }, child: Text("OK"))],
                            ));
                      } else{
                        // submitLogin();
                        onTap: Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainPages()), (route) => false);
                      }
                    },)
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", 
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),),
                    InkWell(
                      onTap:() {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> RegisterPages()), (route) => false);
                      },
                      child: Text("Create account", 
                        style: boldTextStyle.copyWith(
                            color: greenColor, fontSize: 15
                        ),),
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