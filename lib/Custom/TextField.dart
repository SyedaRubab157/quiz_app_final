import 'package:app/Custom/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
class CTextField extends StatelessWidget {
   CTextField({Key? key, this.label,this.quesController,this.onChange}) : super(key: key);

   final void Function(String)? onChange;
   final String? label;
   final TextEditingController? quesController;
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Container(

        width: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            color: Colors.white,
            child:    TextFormField(
              controller: quesController,
              onChanged: onChange,
              autofocus: false,
              decoration: InputDecoration(
                labelText:  label,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.primaryColor)),
                disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: theme.shadowColor)) ,
                labelStyle: GoogleFonts.stylish(textStyle: TextStyle(
              fontSize: 24,
              )),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),),
                errorStyle:
                TextStyle(color: Colors.redAccent, fontSize: 15),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter something';
                }
                return null;
              },
            ),
          ),
        ),
      );
  }
}
