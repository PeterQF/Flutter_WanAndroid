import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/ui/widget/action_button.dart';
import 'package:flutter_wan_android/ui/widget/custom_text_field.dart';
import 'package:flutter_wan_android/utils/screen_utils.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.transparent,
        // 如果为 true，并且指定了 [appBar]，则 [body] 的高度将扩展为包括应用栏的高度
        // 这样AppBar设置为透明色，可以使用body设置的颜色
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              // 需要套一个可以指定高度的widget，否则报错
              // Failed assertion: line 588 pos 12: 'size.isFinite': is not true.
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextField(
                                        hintText: "请输入用户名",
                                        icon: Icon(Icons.person_rounded,
                                            color: Color.fromRGBO(
                                                142, 197, 252, 1.0)),
                                      ),
                                      CustomTextField(
                                        hintText: "您的登录密码",
                                        obscureText: true,
                                        icon: Icon(Icons.lock_rounded,
                                            color: Color.fromRGBO(
                                                142, 197, 252, 1.0)),
                                      ),
                                      ActionButton(
                                        child: Text(
                                          '登录',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: WanColor.white),
                                        ),
                                        onPressed: () => {},
                                      ),
                                      SignupWidget(_nameController)
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
        ));
  }
}

class SignupWidget extends StatefulWidget {
  final nameController;

  SignupWidget(this.nameController);

  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  TapGestureRecognizer _recognizerRegister;

  @override
  void initState() {
    _recognizerRegister = TapGestureRecognizer()
      ..onTap = () async {
        // 将注册成功的用户名,回填如登录框
        widget.nameController.text =
            await Navigator.of(context).pushNamed(RouteName.register);
      };
    super.initState();
  }

  @override
  void dispose() {
    _recognizerRegister.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Text.rich(TextSpan(text: "没有账号？", children: [
          TextSpan(
              text: "去注册",
              recognizer: _recognizerRegister,
              style: TextStyle(color: Theme.of(context).primaryColor))
        ])),
      ),
    );
  }
}
