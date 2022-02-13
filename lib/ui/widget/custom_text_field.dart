import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Icon icon;

  const CustomTextField(
      {Key key, this.hintText = "", this.obscureText = false, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        cursorColor: Color.fromRGBO(142, 197, 252, 1.0),
        cursorRadius: Radius.circular(6),
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          // 未获得焦点下划线设为灰色
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: WanColor.gray, width: 1),
          ),
          //获得焦点下划线设为蓝色
          focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: Color.fromRGBO(142, 197, 252, 1.0), width: 2),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
