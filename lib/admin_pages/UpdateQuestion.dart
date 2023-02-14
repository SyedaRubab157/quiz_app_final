import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import 'ListQuestionPage.dart';
import '../Custom/TextField.dart';

class UpdateQuestion extends StatefulWidget {
  UpdateQuestion({
    Key? key,
    required this.tid,
    required this . qid,
    required this.Clsid,
    required this.Sid,

  }) : super(key: key);
   String tid,Clsid,Sid,qid;


  @override
  State<UpdateQuestion> createState() => _UpdateQuestionState();
}

class _UpdateQuestionState extends State<UpdateQuestion> {
  String? subject;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      subject='';
      // subject = widget.clsName;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final quesController = TextEditingController();
  final w_ans1Controller = TextEditingController();
  final w_ans2Controller = TextEditingController();
  final w_ans3Controller = TextEditingController();
  final c_ansController = TextEditingController();

  Future<void> updateUser(ques, w_ans1, w_ans2, w_ans3, c_ans,) async {

    FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
        .collection('S').doc("${widget.Sid}").collection('T').doc('${widget.tid}').collection('QNA').doc(widget.qid).
    update({'ques': ques, 'w_ans1': w_ans1, 'w_ans2': w_ans2, 'w_ans3': w_ans3, 'c_ans': c_ans,})
        .then((value) => print("User Updated to same class"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Padding(
          padding: EdgeInsets.only(top:14.0),
          child: Text(
            'Update Question',
              style:GoogleFonts.stylish(textStyle: TextStyle(
                fontSize: 34,
              ))
          ),
        ),
      automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: getDataByID(widget.qid,),
                  builder: (BuildContext context, snapshot) {
                    // print("id= ${snapshot.data?.qid}");
                    if (snapshot.hasError) {
                      return Text("Something Went Wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      var data = snapshot.data?.data();

                      quesController.text = data!['ques'];
                      w_ans1Controller.text = data['w_ans1'];
                      w_ans2Controller.text = data['w_ans2'];
                      w_ans3Controller.text = data['w_ans3'];
                      c_ansController.text = data['c_ans'];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                              color: Palette.skyblue),

                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CTextField(
                                  label: 'Question',
                                  quesController: quesController),
                              CTextField(
                                  label: 'Wrong Answer',
                                  quesController: w_ans1Controller),
                              CTextField(
                                  label: 'Wrong Answer',
                                  quesController: w_ans2Controller),
                              CTextField(
                                  label: 'Wrong Answer',
                                  quesController: w_ans3Controller),
                              CTextField(
                                  label: 'Correct Answer',
                                  quesController: c_ansController),
                              SizedBox(
                                height: 17,
                              ),




                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // print("subject from radio ${subject}");
                                        if (_formKey.currentState!.validate()) {
                                          updateUser(
                                            quesController.text,
                                            w_ans1Controller.text,
                                            w_ans2Controller.text,
                                            w_ans3Controller.text,
                                            c_ansController.text,
                                          );

                                          _showToast(context,'Question updated!');
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
                              ),
                            ],
                          ),
                          // ),
                        ),
                      );
                    } else {
                      return Text("data not found");
                    }
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

  getDataByID(String userid, ) {
    print(userid);
    try {
      return FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
          .collection('S').doc("${widget.Sid}").collection('T').doc('${widget.tid}')
          .collection('QNA').doc(userid).get();
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
