import 'package:flutter/material.dart';
final ThemeData tema = ThemeData(
  primarySwatch: MaterialColor(4280438828,{50: Color( 0xffedf7ef )
    , 100: Color( 0xffdbf0e0 )
    , 200: Color( 0xffb7e1c0 )
    , 300: Color( 0xff94d1a1 )
    , 400: Color( 0xff70c282 )
    , 500: Color( 0xff4cb362 )
    , 600: Color( 0xff3d8f4f )
    , 700: Color( 0xff2e6b3b )
    , 800: Color( 0xff1e4827 )
    , 900: Color( 0xff0f2414 )
  }),
  brightness: Brightness.light,
  primaryColor: Color( 0xff22502c ),
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: Color( 0xffdbf0e0 ),
  primaryColorDark: Color( 0xff2e6b3b ),
  accentColor: Color( 0xff1ed760 ),
  accentColorBrightness: Brightness.light,
  canvasColor: Color( 0xfffafafa ),
  scaffoldBackgroundColor: Color( 0xfff5ecd8 ),
  bottomAppBarColor: Color( 0xffffffff ),
  cardColor: Color( 0xffffffff ),
  dividerColor: Color( 0xff5a565d ),
  highlightColor: Color( 0xff87878c ),
  splashColor: Color( 0xff737380 ),
  selectedRowColor: Color( 0xfff5f5f5 ),
  unselectedWidgetColor: Color( 0x8a000000 ),
  disabledColor: Color( 0xff535654 ),
  buttonColor: Color( 0xff7e7e85 ),
  toggleableActiveColor: Color( 0xff3d8f4f ),
  secondaryHeaderColor: Color( 0xffedf7ef ),
  backgroundColor: Color( 0xffb7e1c0 ),
  dialogBackgroundColor: Color( 0xffffffff ),
  indicatorColor: Color( 0xff4cb362 ),
  hintColor: Color( 0x8a000000 ),
  errorColor: Color( 0xffd32f2f ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.only(top:0,bottom:0,left:16, right:16),
    shape: StadiumBorder( side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ) ) ,
    alignedDropdown: true ,
    buttonColor: Color( 0xff7e7e85 ),
    disabledColor: Color( 0xffd0d7d3 ),
    highlightColor: Color( 0x00000000 ),
    splashColor: Color( 0x1fffffff ),
    focusColor: Color( 0x1f000000 ),
    hoverColor: Color( 0x0a000000 ),
    colorScheme: ColorScheme(
      primary: Color( 0xff22502c ),
      primaryVariant: Color( 0xff2e6b3b ),
      secondary: Color( 0xff4cb362 ),
      secondaryVariant: Color( 0xff2e6b3b ),
      surface: Color( 0xffffffff ),
      background: Color( 0xffb7e1c0 ),
      error: Color( 0xffd32f2f ),
      onPrimary: Color( 0xffffffff ),
      onSecondary: Color( 0xff000000 ),
      onSurface: Color( 0xff000000 ),
      onBackground: Color( 0xffffffff ),
      onError: Color( 0xffffffff ),
      brightness: Brightness.light,
    ),
  ),
  inputDecorationTheme:   InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    contentPadding: EdgeInsets.only(top:12,bottom:12,left:0, right:0),
    isCollapsed : false,
    prefixStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: Color( 0x00000000 ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  iconTheme: IconThemeData(
    color: Color( 0xdd000000 ),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: IconThemeData(
    color: Color( 0xffffffff ),
    opacity: 1,
    size: 24,
  ),
  accentIconTheme: IconThemeData(
    color: Color( 0xff000000 ),
    opacity: 1,
    size: 24,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color( 0xffffffff ),
    unselectedLabelColor: Color( 0xb2ffffff ),
  ),
  chipTheme: ChipThemeData(
    backgroundColor: Color( 0xff8884ce ),
    brightness: Brightness.light,
    deleteIconColor: Color( 0xde000000 ),
    disabledColor: Color( 0x0c000000 ),
    labelPadding: EdgeInsets.only(top:0,bottom:0,left:8, right:8),
    labelStyle: TextStyle(
      color: Color( 0xde000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    padding: EdgeInsets.only(top:4,bottom:4,left:4, right:4),
    secondaryLabelStyle: TextStyle(
      color: Color( 0x3d000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    secondarySelectedColor: Color( 0x3d22502c ),
    selectedColor: Color( 0x3d000000 ),
    shape: StadiumBorder( side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ) ),
  ),
  dialogTheme: DialogTheme(
      shape:     RoundedRectangleBorder(
        side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ),
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      )

  ),
);
