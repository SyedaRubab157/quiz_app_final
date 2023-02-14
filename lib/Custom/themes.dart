import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)
          ),buttonColor:  Color(0xFFA6400F).withOpacity(0.6),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFA6400F).withOpacity(0.8),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 28,fontWeight: FontWeight.w600, fontFamily: 'Comfortaa',),
        shadowColor: Colors.black45,
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26))),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData( style: ElevatedButton.styleFrom(
          backgroundColor:Color(0xFFA6400F).withOpacity(0.8),
    textStyle: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize: 18,fontFamily: 'Comfortaa'),
      ),
      ),
      fontFamily: 'Comfortaa',
      primaryColor: Color(0xFFA6400F).withOpacity(0.8),
      accentColor: Color(0xFFFCD8DF),
      hintColor: Color(0xFFD26900),
      backgroundColor: Color(0xFF185358).withOpacity(0.8),
      scaffoldBackgroundColor:
      // Colors.white,
      Color(0xffaabac1),
      shadowColor: Colors.black45,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22)
        ),buttonColor:  Color(0xFF1F3339).withOpacity(0.6),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF1F3339).withOpacity(0.8),
        centerTitle: true,
        shadowColor: Colors.white70,
        titleTextStyle: TextStyle(fontSize: 28,fontWeight: FontWeight.w600, fontFamily: 'Comfortaa'),
        elevation: 6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26))),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData( style: ElevatedButton.styleFrom(
        backgroundColor:Color(0xFF1F3339).withOpacity(0.8),
          textStyle: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600,fontSize: 18,fontFamily: 'Comfortaa'
      )),

      ),
      fontFamily: 'Comfortaa',
      primaryColor: Color(0xFF1F3339).withOpacity(0.8),
      accentColor: Color(0xFFFCD8DF),
      backgroundColor: Color(0xFF185358).withOpacity(0.2),
      hintColor: Color(0xFFD26900),
      scaffoldBackgroundColor: Color(0xFF1D2228),
      shadowColor: Colors.white70,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ),
    );
  }
}

class Palette {
  static Color blue = Color(0xff00113F);
  static Color y_clr = Color(0xffFFaa00);
  static Color skyblue = Color(0xff8ecae6);
  static Color lightblue = Color(0xff219ebc);
  static Color darkblue = Color(0xff023047);
  static Color honey_yellow = Color(0xffffb703);
  static Color orange = Color(0xfffb8500);
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color honey_yellowO = Color(0xffffb703).withOpacity(0.6);

  static Color shade1 = Color(0xffe2e8ea);
  static Color shade2 = Color(0xffc6d1d6);
  static Color shade3 = Color(0xffaabac1);
  static Color shade4 = Color(0xff8ea3ad);
  static Color shade5 = Color(0xff728c98);
  static Color shade6 = Color(0xff567584);
  static Color shade7 = Color(0xff3a5e6f);
  static Color shade8 = Color(0xff1e475b);
  static Color shade9 = Color(0xff023047);
}
