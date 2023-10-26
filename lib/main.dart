import 'package:flutter/material.dart';
import 'package:ptf/screens/login_page.dart';
import 'package:ptf/screens/main_screen.dart';
import 'package:ptf/theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

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
      theme: GirlTheme(context),
      home: const MainScreen(title: "home"),
    );
  }
}

