import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/model/banner_model.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/ui/widget/animated_switcher_widget.dart';
import 'package:flutter_wan_android/ui/widget/article_item_widget.dart';
import 'package:flutter_wan_android/view_model/home_view_model.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';
import 'package:flutter_wan_android/view_model/scroller_controller_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const bannerHeight = 200.0;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("start build ui.widget");
    return Scaffold(
        backgroundColor: WanColor.white,
        body: ProviderWidget2(
          model1: HomeViewModel(),
          /// TitleBarScrollViewModel使用PrimaryScrollController.of(context)会报错
          /// ScrollController attached to multiple scroll views.
          model2: TitleBarScrollViewModel(ScrollController(),
              height: bannerHeight - kToolbarHeight),
          onModelReady: (homeModel, titleBarModel) {
            homeModel.initData();
            titleBarModel.init();
          },
          builder: (context, homeModel, titleBarModel, child) {
            if (homeModel.isLoading) {
              return ViewStateLoadingWidget();
            } else if (homeModel.isError || homeModel.list.isEmpty) {
              return ViewStateWidget(onPressed: () => homeModel.initData());
            } else {
              return SmartRefresher(
                  controller: homeModel.refreshController,
                  header: MaterialClassicHeader(),
                  footer: ClassicFooter(
                    loadingText: "加载中",
                  ),
                  onRefresh: homeModel.refresh,
                  onLoading: homeModel.loadMore,
                  enablePullDown: true,
                  enablePullUp: true,
                  child: CustomScrollView(
                    controller: titleBarModel.scrollController,
                    slivers: [
                      TitleBar(homeModel, titleBarModel),
                      HomeArticleList()
                    ],
                  ));
            }
          },
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeArticleList extends StatelessWidget {
  const HomeArticleList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => ArticleItemWidget(homeViewModel.list[index]),
        childCount: homeViewModel.list?.length ?? 0,
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  final HomeViewModel homeViewModel;
  final TitleBarScrollViewModel titleBarModel;

  const TitleBar(this.homeViewModel, this.titleBarModel, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      // 滑动到顶端时会固定住
      expandedHeight: bannerHeight,
      flexibleSpace: FlexibleSpaceBar(
        title: ShowHideAnimatedSwitcher(
          isShow: titleBarModel.isShow,
          child: Text(
            "首页",
            style: TextStyle(color: WanColor.white),
          ),
        ),
        centerTitle: true,
        background: BannerWidget(homeViewModel),
      ),
      backgroundColor: WanColor.lightBlue,
      //修改状态栏颜色
      systemOverlayStyle: SystemUiOverlayStyle.light,
      actions: [
        ShowHideAnimatedSwitcher(
          isShow: titleBarModel.isShow,
          child: IconButton(
            icon: Icon(Icons.search),
            tooltip: "搜索",
            onPressed: () {
              print("Search Pressed");
            },
          ),
        )
      ],
    );
  }
}

class BannerWidget extends StatelessWidget {
  final HomeViewModel homeViewModel;

  const BannerWidget(this.homeViewModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      key: UniqueKey(),
      itemCount: homeViewModel.banners.length,
      autoplay: true,
      autoplayDelay: 5000,
      loop: true,
      pagination: SwiperPagination(),
      itemBuilder: (context, index) {
        BannerInfo banner = homeViewModel.banners[index];
        return GestureDetector(
          child: Image.network(
            banner.imagePath,
            fit: BoxFit.fill,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(RouteName.articleDetail,
                arguments: ArticleInfo(
                    id: banner.id, title: banner.title, link: banner.url));
          },
        );
      },
    );
  }
}
