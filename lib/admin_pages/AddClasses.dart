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
class AddClasses extends StatefulWidget {


  AddClasses({Key? key , }) : super(key: key);
  @override
  State<AddClasses> createState() => _AddClassesState();
}

class _AddClassesState extends State<AddClasses> {
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    classController.dispose();
    super.dispose();
  }

  String subject = "";
  var classname = "";
var desc='';
  final classController = TextEditingController();
  final dController = TextEditingController();

  Future<void> addClass() async {
    await FirebaseFirestore.instance
        .collection('classes')
        .add({
      'class': classname,
      'description':desc,
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
        title:  Text('Add Class',style: GoogleFonts.stylish(textStyle: TextStyle(
          fontSize: 34,
        )),),
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
                        label: 'Class',
                        quesController: classController),
                    CTextField(
                        label: 'Description',
                        quesController: dController),
                    IconButton(onPressed: ()async{
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
                    },
                        icon: Icon(Icons.camera_alt,color: theme.shadowColor,)),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          setState(() {
                            classname = classController.text;
                            desc=dController.text;
                            addClass();
                            Navigator.pop(context);
                            _showToast(context,' New class added!');
                          });
                        }
                      },
                      child:  Text(
                        'Add',style: GoogleFonts.stylish(textStyle: TextStyle(
                        fontSize: 24,
                      )),
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
