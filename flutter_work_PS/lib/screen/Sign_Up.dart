import 'package:flutter/material.dart';

import 'Login_screen.dart';

class SignUppageinstagram extends StatefulWidget {
  @override
  State<SignUppageinstagram> createState() => _SignUppageinstagramState();
}

class _SignUppageinstagramState extends State<SignUppageinstagram> {
  @override
  void initState() {
    super.initState();
  }
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController password = TextEditingController();




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
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: uihelper.customtextfield(
                    controller: Emailcontroller, text: "Email", tohide: false),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: uihelper.customtextfield(
                    controller: passwordcontroller,
                    text: "Password",
                    tohide: true),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: uihelper.customtextfield(
                    controller: usercontroller, text: "Username", tohide: false),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child:
                    uihelper.custombutton(callback: () {}, buttonname: "Sign Up"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account ",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  uihelper.customtextbutton(
                      value: "Sign In",
                      callback: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Loginscreen()));
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
