import 'package:flutter/material.dart';
import 'package:flutter_wan_android/model/video_model.dart';

class FirstPage extends StatefulWidget {
  final ValueChanged<VideoModel> onJumpToDetail;

  const FirstPage({Key key, this.onJumpToDetail}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('首页'),
            MaterialButton(
              onPressed: () => widget.onJumpToDetail(VideoModel(123456)),
              child: Text('详情'),
            )
          ],
        ),
      ),
    );
  }
}
