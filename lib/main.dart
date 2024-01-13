import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ptf/screens/login/login_page.dart';
import 'package:ptf/screens/main/main_screen.dart';
import 'package:ptf/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}
final logger = Logger();
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hao88.cloud',
      localizationsDelegates:  const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeLight(context),
       home: MainScreen(title: "项目试用期管理"),
      //home: LoginScreen(),
    );
  }
}

