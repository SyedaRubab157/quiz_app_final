import 'package:app/admin_pages/admin_classes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import 'ListQuestionPage.dart';
import '../Custom/TextField.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
class Add_task extends StatefulWidget {


  Add_task({Key? key ,required this.Clsid,
    required this.Sid
  }) : super(key: key);
  @override
  String Clsid;
  String Sid;
  State<Add_task> createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    classController.dispose();
    super.dispose();
  }

  String subject = "";
  var taskname = "";

  final classController = TextEditingController();

  Future<void> addClass() async {
    await  FirebaseFirestore.instance.collection('classes')
        .doc('${widget.Clsid}').collection('S').doc("${widget.Sid}").collection('T')
        .add({
      'task': taskname,
    })
        .then((value) => print('Question Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Add Tasks', style:GoogleFonts.stylish(textStyle: TextStyle(
          fontSize: 34,
        ))),
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Form(
              key: _formKey,
              child:  Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: theme.primaryColor.withOpacity(0.4),
                child: Center(
                  child: Column(children: [
                    SizedBox(height: 10,),
                    CTextField(
                        label: 'Enter Task',
                        quesController: classController),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          setState(() {
                            taskname = classController.text;
                            addClass();
                            Navigator.pop(context);
                            _showToast(context,' New task added!');
                          });
                        }
                      },
                      child:  Text(
                        'Add', style:GoogleFonts.stylish(textStyle: TextStyle(
                        fontSize: 24,
                      ))
                      ),
                    ),


                  ]),
                ),
              ),


            ),  ],
        ),
      ),
    );
  }
}


void _showToast(BuildContext context,title) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18,)),
        ],
      ),
    ),
  );
}
