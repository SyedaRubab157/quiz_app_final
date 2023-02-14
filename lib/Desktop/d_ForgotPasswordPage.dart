import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../Custom/GradientText.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import '../admin_pages/admin_classes.dart';
class d_ForgotPasswordPage extends StatefulWidget {
  const d_ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<d_ForgotPasswordPage> createState() => _d_ForgotPasswordPageState();
}

class _d_ForgotPasswordPageState extends State<d_ForgotPasswordPage> {

  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    final theme=Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width*0.036, vertical:  size.height*0.081),
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.all(Radius.circular(40)
          )
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14, vertical: 16),
                  child: Column(
                    children:[
                      SizedBox(height: 50,),
                      Text('Forgot Password?',
                          style: GoogleFonts.acme(textStyle:TextStyle(
                            fontSize: 80, fontWeight: FontWeight.bold,))),
                      SizedBox(height: 55,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Enter your email here",style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(
                            color: theme.shadowColor,
                            fontWeight: FontWeight.w800,
                            wordSpacing: 0.5),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(

                          prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Colors.amber),
                          labelText: " Email",
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                              color: theme.shadowColor,
                              fontWeight: FontWeight.w600,
                            // color: theme.shadowColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26, width: 1.8),
                            borderRadius: BorderRadius.all(Radius.circular(28.0)),),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber, width: 1.8),
                            borderRadius: BorderRadius.all(Radius.circular(28.0)),),

                        ),

                      ),// Email TextFormField
                      const SizedBox(height: 10,),
                      SizedBox(height: 120),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Palette.honey_yellowO,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(26)),
                          ),
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 22, vertical:15),
                        ),
                        onPressed: () {
                          reset_password( _emailController);
                        },
                        icon: Icon(Icons.navigate_next_outlined,
                            color: Palette.shade7, size: 30),
                        label:GradientText('Reset Password', style: GoogleFonts.scopeOne(textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28, letterSpacing: 0.8),),
                          gradient: LinearGradient(colors: [Palette.shade5,Palette.shade9],begin: FractionalOffset(-1, 0)),),
                      ),
                      //signup button
                      SizedBox(height: 100),


                    ],
                  ),
                ),
              ),
            ),

            // Text(errorMessage, style: const TextStyle(color: Colors.red),),
            Positioned(
                left: 0,
                right: 0,
                bottom: -20,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.black),
                ))

          ],


        ),


      ),

    ) ;


  }
  Future reset_password(TextEditingController _emailController) async {
    try {
      final user = await FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text.trim());

      showDialog(context: context, builder: (context) => AlertDialog(content: Text("Password reset link sent! Check your email"),),);
    } on FirebaseAuthException catch (e) {
      showDialog(context: context, builder: (context) => AlertDialog(content: Text(e.message.toString()),),);

    }

  }





}
