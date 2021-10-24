import 'package:flutter/material.dart';
import 'package:flutter_wan_android/model/video_model.dart';

class SecondPage extends StatefulWidget {
  final VideoModel videoModel;

  const SecondPage(this.videoModel);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('视频详情页，vid: ${widget.videoModel.vid}'),
      ),
    );
  }
}
