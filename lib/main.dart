import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class uihelper {

  //This is for the Login and signup purpose
  static Customtextfield(
      {required TextEditingController controller,
      required String text,
      required bool tohide,
      required TextInputType textinputtype}) {
    return Container(
      height: 44,
      width: 343,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
       border: Border.all(color: Colors.white)
      ,color: const Color(0XFF121212)),
      child: TextField(
        controller: controller,
        obscureText: tohide,
        keyboardType: textinputtype,
        decoration: InputDecoration(
          border: InputBorder.none,
            hintText: text,
            hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white)),
      ),
    );
  }

  static setimage2(String value) {
    return Image.asset("assets/images/$value");
  }

}
