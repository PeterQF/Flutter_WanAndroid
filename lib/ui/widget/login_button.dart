import 'package:flutter/material.dart';
import 'package:flutter_wan_android/ui/widget/button_progress_indicator.dart';
import 'package:flutter_wan_android/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import '../../app/wan_color.dart';

class LoginButton extends StatelessWidget {
  final Gradient gradient;
  final double width;
  final double height;
  final nameController;
  final passwordController;

  const LoginButton({
    Key key,
    @required this.nameController,
    @required this.passwordController,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginViewModel>(context);
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
            onTap: model.isLoading ? null
                : () {
              var formState = Form.of(context);
              if (formState.validate()) {
                model.login(nameController.text, passwordController.text)
                    .then((value) {
                  if (value) {
                    Navigator.of(context).pop(true);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
            },
            borderRadius: BorderRadius.circular(25.0),
            child: Center(
                child: model.isLoading ? ButtonProgressIndicator()
                    : Text(
                  '登录',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: WanColor.white),
                )
            )),
      ),
    );
  }
}
