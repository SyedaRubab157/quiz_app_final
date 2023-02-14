

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import 'ListQuestionPage.dart';
import '../Custom/TextField.dart';

class UpdateClass extends StatefulWidget {
  UpdateClass({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;



  @override
  State<UpdateClass> createState() => _UpdateClassState();
}

class _UpdateClassState extends State<UpdateClass> {
  String? subject;

  @override
  void initState() {
    super.initState();
    setState(() {
      subject='';
    });
  }
  final _formKey = GlobalKey<FormState>();

  final classController = TextEditingController();
  final dController = TextEditingController();

  Future<void> updateClass(classname,desc) async {
    await FirebaseFirestore.instance.collection('classes').doc(widget.id).
    update({
      'class': classname,
      'description':desc,
      'image':imageUrl,
    })
          .then((value) => print("class Updated"))
          .catchError((error) => print("Failed to update class: $error"));
    }
String imageUrl='';
  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Class', style:GoogleFonts.stylish(textStyle: TextStyle(
          fontSize: 24,
        ))),
       automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            Form(
                key: _formKey,
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: getDataByID(widget.id),
                  builder: (_, snapshot) {
                    // print(snapshot.data?.id);
                    if (snapshot.hasError) {
                      return Text("Something Went Wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data != null) {
                      var data = snapshot.data!.data();
                      classController.text = data!['class'];
                      dController.text = data!['description'];
                      return Padding(
                        padding:  EdgeInsets.all(10.0),
                        child:Column(
                          children: [
                            CTextField(
                                label: 'Name', quesController: classController),
                            CTextField(
                                label: 'Description', quesController: dController),
                            SizedBox(height: 10,),
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
                                    await referenceImageToUpload.putFile(File(file!.path) );
                                    imageUrl = await referenceImageToUpload.getDownloadURL();

                                  } catch (error) {
                                  }
                                  Text("${imageUrl}");
                                },
                                icon: Icon(Icons.camera_alt,color: theme.shadowColor,)),
                            SizedBox(height: 8,),

                            ElevatedButton(
                              onPressed: () {
                                print("subject from radio ${subject}");
                                if (_formKey.currentState!.validate()) {
                                  updateClass(
                                    classController.text,
                                    dController.text,

                                  );
                                  _showToast(context,'Class updated!');
                                  Navigator.pop(context);
                                }
                              },
                              child:  Text(
                                'Update',
                                  style:GoogleFonts.stylish(textStyle: TextStyle(
                                    fontSize: 24,
                                  ))
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text("data");
                    }
                  },
                )),

      ),
    );
  }

  getDataByID(String userid, ) {
    print(userid);
    try {
      return FirebaseFirestore.instance.collection("classes").doc(userid).get();
    } catch (e) {
      print(e);
    }
  }

  void _showToast(BuildContext context,title) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Text(title,
                  style: TextStyle(fontSize: 18,fontFamily: 'Comfortaa')),
            ),
          ],
        ),

      ),
    );
  }


}
