import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/page/root_page.dart';

class WanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩安卓',
      //debug版去掉右上角的debug标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          dividerColor: Color(0xffeeeeee),
          scaffoldBackgroundColor: WanColor.paper),
      // home: RootPage(),
      home: RootPage(),
    );
  }
}

/*class _WanAppState extends State<WanApp> {
  WanRouteDelegate _routeDelegate = WanRouteDelegate();
  WanRouteInformationParser _routeInformationParser =
      WanRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WanDataStore>(
      //进行data store初始化
      future: WanDataStore.preInit(),
      builder: (BuildContext context, AsyncSnapshot<WanDataStore> snapshot) {
        //定义router
        //判断widget是否已加载，如果加载了显示route，否则显示loading
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(
                routeInformationParser: _routeInformationParser,
                routerDelegate: _routeDelegate,

                ///routeInformationParser为null时可缺省，routeInformation提供者
                routeInformationProvider: PlatformRouteInformationProvider(
                    initialRouteInformation: RouteInformation(location: "/")),
              )
            : Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
        return MaterialApp(
          title: '玩安卓',
          //debug版去掉右上角的debug标签
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.white,
              dividerColor: Color(0xffeeeeee),
              scaffoldBackgroundColor: WanColor.paper),
          // home: RootPage(),
          home: widget,
        );
      },
    );
  }
}*/
