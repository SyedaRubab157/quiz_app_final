import 'package:app/Desktop/d_SignIn.dart';
import 'package:app/Mobile/mobile.dart';
import 'package:app/admin_pages/admin_subjects.dart';
import 'package:app/m/QuizPage.dart';
import 'package:app/Mobile/sign_up.dart';
import 'package:app/Custom/feedback.dart';
import 'package:app/Mobile/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'C.dart';
import 'Custom/themes.dart';
import 'admin_pages/admin_classes.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'm/Subject_List.dart';
import 'Mobile/F-screen.dart';
import 'm/finishPage.dart';
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent,));
// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(  MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override


  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });}
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: CustomTheme.darkTheme,
        // darkTheme: CustomTheme.lightTheme,

         theme: CustomTheme.lightTheme,
        darkTheme: CustomTheme.darkTheme,

        themeMode: currentTheme.currentTheme,
        home:
        // classes(),
          // C(id: 'MKflBilOYjc0zrpVMtQl',),
        F_screen(),
        // finishPage(score: '10', Loginemail: 'syeda@gmamil.com',),
        // F_screen(),
        // HomePage(Loginemail: 'syeda47@gmail.com',),
      ),
       designSize: const Size(360, 690),
     );

  }
}
