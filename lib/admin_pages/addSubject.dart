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

import 'admin_subjects.dart';
class Add_Subject extends StatefulWidget {

  Add_Subject({Key? key,
  required this. Clsid,
  }) : super(key: key);
  String Clsid;
  @override
  State<Add_Subject> createState() => _Add_SubjectState();
}

class _Add_SubjectState extends State<Add_Subject> {
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    classController.dispose();
    super.dispose();
  }

  String subject = "";
  var s_name = "";

  final classController = TextEditingController();

  Future<void> addClass() async {
    await
    FirebaseFirestore.instance.collection('classes')
        .doc('${widget.Clsid}').collection('S')
        .add({
      'subject': s_name,
      'image':imageUrl,
    })
        .then((value) => print('Question Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Add Subject',),
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
                        label: 'subject name',
                        quesController: classController),

                    IconButton(
                        onPressed: ()async{
                      ImagePicker imagepicker=ImagePicker();
                      XFile? file=await  imagepicker.pickImage(source: ImageSource.gallery);
                      print('image path= ${file?.path}');

                      if (file == null) return;
                      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
                      //Get a reference to storage root
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                      referenceRoot.child('images');
                      //Create a reference for the image to be stored
                      Reference referenceImageToUpload =
                      referenceDirImages.child(uniqueFileName);
                      try {
                        await referenceImageToUpload.putFile(File(file!.path));
                        imageUrl = await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                      }
                      Text("${imageUrl}");
                    },
                        icon: Icon(Icons.camera_alt,color: theme.shadowColor,)),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          setState(() {
                            s_name = classController.text;
                            addClass();
                            Navigator.pop(context);
                            _showToast(context,' New subject added!');
                          });
                        }
                      },
                      child:  Text(
                        'Add', style:GoogleFonts.stylish(textStyle: TextStyle(
                        fontSize: 24,
                      )
                      ),
                    ),

                    )
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
