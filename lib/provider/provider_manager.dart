

import 'package:flutter_wan_android/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices
];

/// 独立的view model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (context) => UserViewModel(),)
];