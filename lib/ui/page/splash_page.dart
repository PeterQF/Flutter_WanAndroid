import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/app_resource.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/utils/screen_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  AnimationController _countdownController;

  @override
  void initState() {
    super.initState();
    _countdownController = AnimationController(vsync: this, duration: Duration(seconds: 4));
    _countdownController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: Screen.width / 2,
                height: Screen.width / 2,
                child: Image.asset(ImageHelper.loadAssets('image/image_splash.png')),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                child: InkWell(
                    onTap: () {
                      nextPage(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      margin: EdgeInsets.only(right: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.withAlpha(100),
                      ),
                      child: AnimatedCountdown(
                        context: context,
                        animation: StepTween(begin: 3, end: 0)
                            .animate(_countdownController),
                      ),
                    )
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {

  final Animation<int> animation;

  AnimatedCountdown({key, this.animation, context}) : super(
    key: key,
    listenable: animation
  ) {
    this.animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        nextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text((value == 0 ? "" : "$value | ") + "跳过",
      style: TextStyle(color: WanColor.lightBlue),
    );
  }
}

void nextPage(context) {
  Navigator.of(context).pushReplacementNamed(RouteName.main);
}
