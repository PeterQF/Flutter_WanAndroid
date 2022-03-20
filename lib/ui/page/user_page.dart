import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/app_resource.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/utils/screen_utils.dart';
import 'package:flutter_wan_android/view_model/user_page_scroll_view_model.dart';
import 'package:lottie/lottie.dart';
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
      body: ProviderWidget(
        model: UserPageScrollViewModel(
            context, animationController, ScrollController()),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          if (model.isLogin) {
            return Listener(
              onPointerMove: (result) {
                model.updatePicHeight(result.position.dy);
              },
              onPointerUp: (event) {
                model.runAnimate();
                animationController.forward(from: 0);
              },
              child: SmartRefresher(
                  controller: model.refreshController,
                  header: MaterialClassicHeader(),
                  onRefresh: model.refresh,
                  child: CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: model.scrollController,
                    slivers: [
                      SliverAppBar(
                        // 先滑动列表到顶部在展开SliverAppBar
                        // 设置为true时，向下滑动时，即使当前CustomScrollView不在顶部，SliverAppBar也会跟着一起向下出现
                        floating: false,
                        pinned: true,
                        // 默认情况下为true，则指定了expandedHeight的高度，expandedHeight会加上状态栏高度的
                        // 比如指定了expandedHeight = 200，假设状态栏高度60，则真正的expandedHeight值为260
                        // 如果primary为true，则SliverTopBar的高度需要加上状态栏高度，否则会显示不完整
                        // 所以这里把primary改为false，不包含状态栏高度，则SliverTopBar的高度不需要再加上状态栏高度
                        primary: false,
                        // 导航栏下面是否一直显示阴影
                        forceElevated: false,
                        expandedHeight:
                            userPageAppBarHeight + model.extraPicHeight,
                        backgroundColor: WanColor.lightBlue,
                        systemOverlayStyle: SystemUiOverlayStyle.light,
                        flexibleSpace: FlexibleSpaceBar(
                            background: SliverTopBar(model),
                            // 先收缩flexibleSpace部分再滑动列表
                            // 背景 固定到位，直到达到最小范围。 默认是CollapseMode.parallax(将以视差方式滚动。)，还有一个是none，滚动没有效果
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
    return Stack(
      children: [
        SizedBox(
          width: screenWidth,
          height: userPageAppBarHeight + model.extraPicHeight,
          child: Image.asset(
            ImageHelper.loadAssets("image/image_zero.JPG"),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 16,
          bottom: 10,
          // 这里设置left时如果设置的width为屏幕宽度，还需要把left减掉，否则最右边的控件会遮住left长度的部分
          width: screenWidth - 16,
          child: UserInfoWidget(),
        )
      ],
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/image/avatar.JPG"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Peter",
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
            "点击这里，填写个性签名",
            style: TextStyle(fontSize: 14, color: WanColor.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            Text("1176\n积分",
                style: TextStyle(fontSize: 12, color: WanColor.white),
                textAlign: TextAlign.center),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "12\n等级",
                style: TextStyle(fontSize: 12, color: WanColor.white),
                textAlign: TextAlign.center,
              ),
            ),
            Text("1609\n排名",
                style: TextStyle(fontSize: 12, color: WanColor.white),
                textAlign: TextAlign.center),
            Expanded(child: SizedBox.shrink()),
            Text(
              "编辑资料",
              style: TextStyle(fontSize: 14, color: WanColor.white),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "设置",
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
            icon: Icon(Icons.settings_rounded, color: WanColor.gray,),
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
                '😮 你竟然忘记登录 😮',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteName.login);
                },
                child: Text(
                  "去登录",
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
