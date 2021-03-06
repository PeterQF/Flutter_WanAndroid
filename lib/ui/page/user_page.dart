import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/app_resource.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/user_model.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/ui/widget/action_button.dart';
import 'package:flutter_wan_android/utils/screen_utils.dart';
import 'package:flutter_wan_android/utils/wan_utils.dart';
import 'package:flutter_wan_android/view_model/user_page_scroll_view_model.dart';
import 'package:flutter_wan_android/view_model/user_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const userPageAppBarHeight = 250;

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ProviderWidget2(
        model1: UserPageScrollViewModel(
            context, animationController, ScrollController()),
        model2: Provider.of<UserViewModel>(context),
        onModelReady: (scrollModel, userModel) {
          scrollModel.init();
          userModel.init();
        },
        builder: (context, scrollModel, userModel, child) {
          if (userModel.isLogin) {
            return Listener(
              onPointerMove: (result) {
                scrollModel.updatePicHeight(result.position.dy);
              },
              onPointerUp: (event) {
                scrollModel.runAnimate();
                animationController.forward(from: 0);
              },
              child: SmartRefresher(
                  controller: scrollModel.refreshController,
                  header: MaterialClassicHeader(),
                  onRefresh: scrollModel.refresh,
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollModel.scrollController,
                    slivers: [
                      SliverAppBar(
                        // ?????????????????????????????????SliverAppBar
                        // ?????????true????????????????????????????????????CustomScrollView???????????????SliverAppBar??????????????????????????????
                        floating: false,
                        pinned: true,
                        // ??????????????????true???????????????expandedHeight????????????expandedHeight???????????????????????????
                        // ???????????????expandedHeight = 200????????????????????????60???????????????expandedHeight??????260
                        // ??????primary???true??????SliverTopBar???????????????????????????????????????????????????????????????
                        // ???????????????primary??????false?????????????????????????????????SliverTopBar??????????????????????????????????????????
                        primary: false,
                        // ???????????????????????????????????????
                        forceElevated: false,
                        expandedHeight:
                            userPageAppBarHeight + scrollModel.extraPicHeight,
                        backgroundColor: WanColor.lightBlue,
                        systemOverlayStyle: SystemUiOverlayStyle.light,
                        flexibleSpace: FlexibleSpaceBar(
                            background: SliverTopBar(scrollModel),
                            // ?????????flexibleSpace?????????????????????
                            // ?????? ?????????????????????????????????????????? ?????????CollapseMode.parallax(???????????????????????????)??????????????????none?????????????????????
                            collapseMode: CollapseMode.pin),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Container(
                            height: 20,
                            child: Text("Peter$index"),
                          );
                        }, childCount: 50),
                      )
                    ],
                  )),
            );
          } else {
            return NoLoginPage();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SliverTopBar extends StatelessWidget {
  final UserPageScrollViewModel model;

  const SliverTopBar(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    String background = userViewModel.user.background;
    return Stack(
      children: [
        SizedBox(
            width: screenWidth,
            height: userPageAppBarHeight + model.extraPicHeight,
            child: Image.asset(
              ImageHelper.loadAssets(WanUtils.isNull(background) ? "image/image_placeholder.png" : background),
              fit: BoxFit.cover,
            )),
        Positioned(
          left: 16,
          bottom: 10,
          // ????????????left??????????????????width??????????????????????????????left??????????????????????????????????????????left???????????????
          width: screenWidth - 16,
          child: UserInfoWidget(userViewModel),
        )
      ],
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  final UserViewModel userViewModel;

  const UserInfoWidget(this.userViewModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User userInfo = userViewModel.user;
    String icon = userInfo.icon;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(
                ImageHelper.loadAssets(WanUtils.isNull(icon) ? "image/image_default_avatar.png" : icon),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                userInfo.nickname,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: WanColor.white,
                    fontSize: 20),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(
            "?????????????????????????????????",
            style: TextStyle(fontSize: 14, color: WanColor.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            Text("-\n??????",
                style: TextStyle(fontSize: 12, color: WanColor.white),
                textAlign: TextAlign.center),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "-\n??????",
                style: TextStyle(fontSize: 12, color: WanColor.white),
                textAlign: TextAlign.center,
              ),
            ),
            Text("-\n??????",
                style: TextStyle(fontSize: 12, color: WanColor.white),
                textAlign: TextAlign.center),
            Expanded(child: SizedBox.shrink()),
            ActionButton(
              width: 60,
              height: 40,
              child: Text(
                "????????????",
                style: TextStyle(fontSize: 14, color: WanColor.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "??????",
                style: TextStyle(fontSize: 14, color: WanColor.white),
              ),
            )
          ],
        )
      ],
    );
  }
}

class NoLoginPage extends StatelessWidget {
  const NoLoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WanColor.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: WanColor.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings_rounded,
              color: WanColor.gray,
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/lottie/no_login.json",
              width: Screen.width / 1.3,
              height: 160,
              fit: BoxFit.fill,
              alignment: Alignment.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '???? ????????????????????? ????',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteName.login);
                },
                child: Text(
                  "?????????",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)))
          ],
        ),
      ),
    );
  }
}
