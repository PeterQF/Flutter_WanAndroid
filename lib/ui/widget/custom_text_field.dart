import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final FocusNode focusNode;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;

  const CustomTextField(
      {Key key,
      this.hintText = "",
      this.obscureText = false,
      this.icon,
      this.focusNode,
      this.controller,
      this.validator,
      this.textInputAction,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  TextEditingController controller;
  /// 默认遮挡密码
  ValueNotifier<bool> obscureNotifier;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    obscureNotifier = ValueNotifier(widget.obscureText);
    super.initState();
  }

  @override
  void dispose() {
    obscureNotifier.dispose();
    // 如果默认没有传入controller,需要内部释放
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ValueListenableBuilder(
        valueListenable: obscureNotifier,
        builder: (context, value, child) => TextFormField(
          controller: controller,
          obscureText: value,
          validator: (text) {
            var validator = widget.validator ?? (_) => null;
            return text.trim().length > 0
                ? validator(text)
                : "输入内容不能为空";
          },
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          cursorColor: Color.fromRGBO(142, 197, 252, 1.0),
          cursorRadius: Radius.circular(6),
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            hintText: widget.hintText,
            // 未获得焦点下划线设为灰色
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: WanColor.gray, width: 1),
            ),
            //获得焦点下划线设为蓝色
            focusedBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Color.fromRGBO(142, 197, 252, 1.0), width: 2),
            ),
            suffixIcon: LoginTextFieldSuffixIcon(
              controller: controller,
              obscureText: widget.obscureText,
              obscureNotifier: obscureNotifier,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextFieldSuffixIcon extends StatelessWidget {
  final TextEditingController controller;

  final ValueNotifier<bool> obscureNotifier;

  final bool obscureText;

  LoginTextFieldSuffixIcon(
      {this.controller, this.obscureNotifier, this.obscureText});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Offstage(
          offstage: !obscureText,
          child: InkWell(
            onTap: () {
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: ValueListenableBuilder(
              valueListenable: obscureNotifier,
              builder: (context, value, child) => Icon(
                CupertinoIcons.eye,
                size: 20,
                color: value ? theme.hintColor : WanColor.lightBlue,
              ),
            ),
          ),
        ),
        LoginTextFieldClearIcon(controller)
      ],
    );
  }
}

class LoginTextFieldClearIcon extends StatefulWidget {
  final TextEditingController controller;

  LoginTextFieldClearIcon(this.controller);

  @override
  _LoginTextFieldClearIconState createState() =>
      _LoginTextFieldClearIconState();
}

class _LoginTextFieldClearIconState extends State<LoginTextFieldClearIcon> {
  ValueNotifier<bool> notifier;

  @override
  void initState() {
    notifier = ValueNotifier(widget.controller.text.isEmpty);
    widget.controller.addListener(() {
      if(mounted) notifier.value = widget.controller.text.isEmpty;
    });
    super.initState();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, bool value, child) {
        return Offstage(
          offstage: value,
          child: child,
        );
      },
      child: InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.controller.clear();
            });
          },
          child: Icon(CupertinoIcons.clear,
              size: 20, color: Theme.of(context).hintColor)),
    );
  }
}

