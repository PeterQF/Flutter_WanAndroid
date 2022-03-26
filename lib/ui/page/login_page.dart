import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/ui/widget/custom_text_field.dart';
import 'package:flutter_wan_android/utils/screen_utils.dart';
import 'package:flutter_wan_android/view_model/login_view_model.dart';
import 'package:flutter_wan_android/view_model/user_page_scroll_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../widget/button_progress_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _pwdFocus.unfocus();
    _pwdFocus.dispose();
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
              child: ProviderWidget(
                model: LoginViewModel(Provider.of(context)),
                onModelReady: (model) {
                  print("login view model ready");
                  _nameController.text = model.getLoginName();
                },
                builder: (context, model, child) {
                  return Form(
                    onWillPop: () async {
                      return !model.isLoading;
                    },
                    child: LoginContainer(
                        model, _nameController, _passwordController, _pwdFocus),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class LoginContainer extends StatelessWidget {
  final LoginViewModel loginViewModel;
  final nameController;
  final passwordController;
  final FocusNode pwdFocus;

  const LoginContainer(this.loginViewModel, this.nameController,
      this.passwordController, this.pwdFocus,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                              hintText: "请输入用户名",
                              icon: Icon(Icons.person_rounded,
                                  color: Color.fromRGBO(142, 197, 252, 1.0)),
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (text) {
                                FocusScope.of(context).requestFocus(pwdFocus);
                              },
                              controller: nameController,
                            ),
                            CustomTextField(
                              hintText: "您的登录密码",
                              obscureText: true,
                              icon: Icon(Icons.lock_rounded,
                                  color: Color.fromRGBO(142, 197, 252, 1.0)),
                              textInputAction: TextInputAction.done,
                              focusNode: pwdFocus,
                              controller: passwordController,
                            ),
                            LoginButton(
                                loginViewModel: loginViewModel,
                                nameController: nameController,
                                passwordController: passwordController),
                            SignupWidget(nameController)
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
    );
  }
}

class LoginButton extends StatelessWidget {
  final Gradient gradient;
  final double width;
  final double height;
  final LoginViewModel loginViewModel;
  final nameController;
  final passwordController;

  const LoginButton({
    Key key,
    @required this.loginViewModel,
    @required this.nameController,
    @required this.passwordController,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(142, 197, 252, 1.0),
              Color.fromRGBO(224, 195, 252, 1.0),
            ],
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: loginViewModel.isLoading
                ? null
                : () {
                    var formState = Form.of(context);
                    if (formState.validate()) {
                      loginViewModel
                          .login(nameController.text, passwordController.text)
                          .then((value) {
                        if (value) {
                          Navigator.of(context).pop(true);
                        } else {
                          loginViewModel.showErrorMessage(context);
                        }
                      });
                    }
                  },
            borderRadius: BorderRadius.circular(25.0),
            child: Center(
                child: loginViewModel.isLoading
                    ? ButtonProgressIndicator()
                    : Text(
                        '登录',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: WanColor.white),
                      ))),
      ),
    );
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
