import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailPage extends StatefulWidget {
  final ArticleInfo articleInfo;

  const ArticleDetailPage(this.articleInfo, {Key key}) : super(key: key);

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  Completer<bool> _finishedCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: WanColor.lightBlue,
        title: Text(
          widget.articleInfo.title,
          style: TextStyle(
              fontSize: 18, color: WanColor.white, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(widget.articleInfo.title + ' ' + widget.articleInfo.link);
            },
            icon: Icon(Icons.share_rounded),
          )
        ],
      ),
      body: FutureBuilder(
          future: _finishedCompleter.future,
          initialData: false,
          builder: (context, snapshot) => Stack(
                children: [
                  WebViewBody(widget.articleInfo.link, _finishedCompleter),
                  Positioned(
                    child: _finishedCompleter.isCompleted
                        ? SizedBox.shrink()
                        : ViewStateLoadingWidget(),
                  )
                ],
              )),
    );
  }
}

class WebViewBody extends StatelessWidget {
  final String link;
  final Completer<bool> finishedCompleter;

  const WebViewBody(this.link, this.finishedCompleter, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        // 初始化加载的url
        initialUrl: link,
        // 加载js
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String value) async {
          if (!finishedCompleter.isCompleted) {
            finishedCompleter.complete(true);
          }
        },
      ),
    );
  }
}
