import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../responsive.dart';

// final ThemeData appTheme = ThemeData(
//
//
//
// );

ButtonStyle buttonStyle(context) {
  return TextButton.styleFrom(
    padding: EdgeInsets.symmetric(
      horizontal: defaultPadding * 1.5,
      vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
    ),
  );
}

ThemeData ThemeDark(context) {
  return ThemeData.dark().copyWith(
    backgroundColor: bgColor,
    dialogTheme: DialogTheme(backgroundColor: bgColor),
    scaffoldBackgroundColor: bgColor,
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
        fontFamily: 'Regular',
        bodyColor: Colors.white,
        displayColor: Colors.white70),
    canvasColor: secondaryColor,
    cardColor: secondaryColor,
    dividerColor: secondaryColor,
    cardTheme: CardTheme(
      elevation: 5.0,
      color: secondaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))), //设置圆角
    ),
    iconTheme: IconTheme.of(context).copyWith(
      color: Colors.white54,
      size: 18,
    ),
  );
}

ThemeData ThemeLight(context) {
  return ThemeData.light().copyWith(
    //dialogTheme: DialogTheme(backgroundColor: bgColor1),
    // scaffoldBackgroundColor: bgColor1,
    //canvasColor: secondaryColor1,
    cardColor: Colors.white,
    dividerColor: Colors.white60,
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
      fontFamily: 'Regular',
      //bodyColor: Colors.black,
      //displayColor: Colors.black45,
    ),
    iconTheme: IconTheme.of(context).copyWith(
      color: Colors.black54,
      size: 18,
    ),

    cardTheme: CardTheme(
      elevation: 5.0,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))), //设置圆角
    ),

  );
}
ThemeData GirlTheme(context){
  return  ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
}
const outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 1, color: Colors.blueGrey),
  borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 2)),
);

TextStyle? formTextStyle(context) {
  return Theme.of(context).primaryTextTheme.subtitle2;
}
