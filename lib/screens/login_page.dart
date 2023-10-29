import 'package:flutter/material.dart';
import 'package:ptf/responsive.dart';
import 'package:ptf/theme/theme.dart';
import 'package:ptf/utils/http.dart';
import 'package:ptf/wiidget/tip.dart';

import '../constants.dart';
import 'main_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String user = '';
  String pwd = '';

  void toMain() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(title: '周期管理系统',)));
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) =>MainScreen(title: '周期管理系统',)),
      (route) => route == null,
    );
  }

  void login() {
    var currentState = _formKey.currentState;
    if (currentState!.validate()) {
      currentState.save();
      loginRequest(user,pwd);
    }
  }

  void loginRequest(String user,String pwd) async {
    try {
      //var json = await HttpUtils.post("/admin/login", "{}");
      // var response = ResponseEntity.fromJson(json);
      // if (response.code == success) {
      //   toMain();
      // } else {
      //   errTip(response.msg);
      // }
      if(user=="admin"&&pwd=="668899"){
        toMain();
      }
    } catch (e) {
      errTip(e);
    }
  }

  void errTip(tip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Tip(tip: tip),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  var centerLayout=  LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        //   verticalMargin = window.physicalSize.width/4;
        //   horizontalMargin = window.physicalSize.width/4;
        double  paddingVertical =constraints.maxHeight /35;
        double paddingHorizontal =constraints.maxWidth /30;
        double cardWidth = constraints.maxWidth / 2;
        double cardHeight = constraints.maxHeight/ 2;
        if (Responsive.isDesktop(context)) {
          paddingVertical=constraints.maxHeight/35;
          paddingHorizontal=constraints.maxWidth/20;
          cardWidth = constraints.maxWidth / 2.5;
        }
        if (Responsive.isMobile(context)) {
          paddingVertical=constraints.maxHeight/35;
          paddingHorizontal=constraints.maxWidth/30;
          cardWidth= constraints.maxWidth/1.5;
        }
        if (Responsive.isTablet(context)) {
          paddingVertical=constraints.maxHeight/35;
          paddingHorizontal=constraints.maxWidth/20;
          cardWidth= constraints.maxWidth/1.5;
        }
        return Card(elevation: 15.0, color: Theme.of(context).canvasColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))),
      //设置圆角
      child: Form(
        key: _formKey,
        child: Padding(
          padding: defaultPaddingAll,
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: paddingVertical,bottom: paddingVertical),
          child: const Center(
            child: Text("周期管理系统"),
          ),
        ),
        Padding(
          padding:EdgeInsets.only(top: paddingVertical,left: paddingHorizontal,right: paddingHorizontal),
          child: TextFormField(
            onSaved: (value) {
              user = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '用户名为空';
              }
              return null;
            },
            decoration: InputDecoration(
                hoverColor: Theme.of(context).hoverColor,
                border: outlineInputBorder,
                labelText: '用户名',
                hintText: '请输入用户名'),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: paddingVertical,bottom: paddingVertical,left: paddingHorizontal,right: paddingHorizontal),
          child: TextFormField(
            onSaved: (value) {
              pwd = value!;
            },
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '密码为空';
              }
              return null;
            },
            decoration: InputDecoration(
                hoverColor: Theme.of(context).highlightColor,
                //labelStyle: formTextStyle(context),
                //hintStyle: formTextStyle(context),
                border: outlineInputBorder,
                labelText: '密码',
                hintText: '请输入密码'),
          ),
        ),
        Padding(
          padding:EdgeInsets.only(top: paddingVertical,bottom: paddingVertical),
          child: ElevatedButton(
            style: buttonStyle(context),
            onPressed: () {
              login();
            },
            child: const Text(
              '登录',
            ),
          ),
        ),
      ],
    ),
          ),
        ),
      ),
    );
        },
  );
    var center =Center(child: centerLayout);
    var singleChildScrollView = SingleChildScrollView(child: center, primary: false,);
    return Scaffold(body: center);
  }
}
