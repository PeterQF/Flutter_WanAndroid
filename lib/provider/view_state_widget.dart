import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/app_resource.dart';
import 'package:flutter_wan_android/app/wan_color.dart';

/// 加载中loading
class ViewStateLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: WanColor.lightBlue,
      ),
    );
  }
}

class ViewStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  const ViewStateWidget(
      {Key key,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image ??
            Image.asset(
              ImageHelper.loadAssets('img/error_no_data.png'),
              width: 64,
              height: 64,
            ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message ?? "暂无数据",
                style: TextStyle(color: WanColor.color707070, fontSize: 16),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        Center(
          child: ViewStateButton(
            child: buttonText,
            textData: buttonTextData,
            onPressed: onPressed,
          ),
        )
      ],
    );
  }
}

/// button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String textData;

  const ViewStateButton(
      {Key key, @required this.onPressed, this.textData, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: child ??
          Text(
            textData ?? "重试",
            style: TextStyle(
                wordSpacing: 5, color: WanColor.white, fontSize: 16),
          ),
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(WanColor.lightBlue)),
      onPressed: onPressed,
    );
  }
}
