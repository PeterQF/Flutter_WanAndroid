import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/ui/widget/custom_text_field.dart';
import 'package:flutter_wan_android/utils/screen_utils.dart';
import 'package:flutter_wan_android/utils/toast_utils.dart';
import 'package:flutter_wan_android/view_model/register_view_model.dart';
import 'package:lottie/lottie.dart';

import '../widget/button_progress_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
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
            child: ProviderWidget(
              model: RegisterViewModel(),
              builder: (context, model, child) {
                return Form(
                  onWillPop: () async {
                    return !model.isLoading;
                  },
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
                                padding:
                                    EdgeInsets.only(left: 16.0, right: 16.0),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomTextField(
                                            hintText: "用户名",
                                            icon: Icon(Icons.person_rounded,
                                                color: Color.fromRGBO(
                                                    142, 197, 252, 1.0)),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: _nameController,
                                          ),
                                          CustomTextField(
                                            hintText: "密码",
                                            obscureText: true,
                                            icon: Icon(Icons.lock_rounded,
                                                color: Color.fromRGBO(
                                                    142, 197, 252, 1.0)),
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: _passwordController,
                                          ),
                                          CustomTextField(
                                            hintText: "确认密码",
                                            obscureText: true,
                                            icon: Icon(Icons.lock_rounded,
                                                color: Color.fromRGBO(
                                                    142, 197, 252, 1.0)),
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: _rePasswordController,
                                            validator: (value) {
                                              return value !=
                                                      _passwordController.text
                                                  ? "两次输入密码不一致"
                                                  : null;
                                            },
                                          ),
                                          RegisterButton(
                                              _nameController,
                                              _passwordController,
                                              _rePasswordController,
                                              model),
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final nameController;
  final passwordController;
  final rePasswordController;
  final RegisterViewModel registerViewModel;
  final Gradient gradient;
  final double width;
  final double height;

  const RegisterButton(
    this.nameController,
    this.passwordController,
    this.rePasswordController,
    this.registerViewModel, {
    Key key,
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
            onTap: registerViewModel.isLoading
                ? null
                : () {
                    var formState = Form.of(context);
                    if (formState.validate()) {
                      registerViewModel
                          .signup(nameController.text, passwordController.text,
                              rePasswordController.text)
                          .then((value) {
                        if (value) {
                          ToastUtils.show("注册成功");
                          Navigator.of(context).pop(nameController.text);
                        } else {
                          registerViewModel.showErrorMessage(context);
                        }
                      });
                    }
                  },
            borderRadius: BorderRadius.circular(25.0),
            child: Center(
                child: registerViewModel.isLoading
                    ? ButtonProgressIndicator()
                    : Text(
                        '注册',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: WanColor.white),
                      ))),
      ),
    );
  }
}
