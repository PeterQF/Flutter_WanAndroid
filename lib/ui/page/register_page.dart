import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/ui/widget/action_button.dart';
import 'package:flutter_wan_android/ui/widget/custom_text_field.dart';
import 'package:flutter_wan_android/utils/screen_utils.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: Screen.height,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                stops: [
                                  0.0,
                                  1.0
                                ],
                                colors: [
                                  Color.fromRGBO(139, 198, 236, 1.0),
                                  Color.fromRGBO(149, 153, 226, 1.0),
                                ])),
                      )),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Lottie.asset(
                            "assets/lottie/android_lottie.json",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: WanColor.white,
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextField(
                                      hintText: "用户名",
                                      icon: Icon(Icons.person_rounded,
                                          color:
                                          Color.fromRGBO(142, 197, 252, 1.0)),
                                    ),
                                    CustomTextField(
                                      hintText: "密码",
                                      obscureText: true,
                                      icon: Icon(Icons.lock_rounded,
                                          color:
                                          Color.fromRGBO(142, 197, 252, 1.0)),
                                    ),
                                    CustomTextField(
                                      hintText: "确认密码",
                                      obscureText: true,
                                      icon: Icon(Icons.lock_rounded,
                                          color:
                                          Color.fromRGBO(142, 197, 252, 1.0)),
                                    ),
                                    ActionButton(
                                      child: Text(
                                        '注册',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: WanColor.white),
                                      ),
                                      onPressed: () => {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
