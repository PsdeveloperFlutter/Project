//Login Screen in dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home_page/Home_Page.dart';
import 'Sign_Up.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Loginscreen()));
}

TextEditingController emailcontroller = TextEditingController();
TextEditingController passwordcontroller = TextEditingController();

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              uihelper
                  .setimage("https://i.postimg.cc/L52W3XvS/Instagram-Logo.png"),
              const SizedBox(
                height: 17,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: uihelper.customtextfield(
                    controller: emailcontroller, text: "Email", tohide: false),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: uihelper.customtextfield(
                    controller: passwordcontroller,
                    text: "Password",
                    tohide: true),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: uihelper.customtextbutton(
                          value: "Forget password ?", callback: () {})),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child:
                    uihelper.custombutton(callback: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomNavScreen()));
                    }, buttonname: "Log In"),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  uihelper.setimage("https://i.postimg.cc/28By1SXF/Icon.png"),
                  uihelper.customtextbutton(
                      value: "Login in with Facebook", callback: () {
                  })
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "OR",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                   uihelper.customtextbutton(value: "Sign Up", callback: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUppageinstagram ()));
                   })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//This class responsible for the customization of the widget for the various UI purpose
class uihelper {
  static setimage(String imagevalue) {
    return Image.network("$imagevalue");
  }
  static setimage2(String value){
    return Image.asset("$value");
  }
  //This code is for the custom button ui in the flutter in the project of the instagram
  static customtextbutton(
      {required String value, required VoidCallback callback}) {
    return TextButton(
        onPressed: () {
          callback();
        },
        child: Text(
          "$value",
          style: const TextStyle(color: Color(0XFF3797EF), fontSize: 12),
        ));
  }

  static custombutton(
      {required VoidCallback callback, required String buttonname}) {
    return SizedBox(
      height: 45,
      width: 343,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0XFF3797EF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(
          "$buttonname",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  //This class is the CustomTextField
  static customtextfield(
      {required TextEditingController controller,
      required String text,
      required bool tohide}) {
    return Container(
      height: 50,
      width: 343,
      decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade700)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextField(
          controller: controller,
          obscureText: tohide,
          decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(fontSize: 14, color: Colors.white70),
              border: InputBorder.none),
        ),
      ),
    );
  }
}
