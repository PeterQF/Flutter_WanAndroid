import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
