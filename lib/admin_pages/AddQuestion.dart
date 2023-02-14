import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Custom/colors.dart';
import '../Custom/themes.dart';
import 'ListQuestionPage.dart';
import '../Custom/TextField.dart';

class AddQuestion extends StatefulWidget {
  AddQuestion({Key? key ,
    required this.tid,
    required this.Clsid,
    required this.Sid,
  }) : super(key: key);
 String Clsid,Sid,tid;
  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    quesController.dispose();
    c_ansController.dispose();
    w_ans1Controller.dispose();
    w_ans2Controller.dispose();
    w_ans3Controller.dispose();
    super.dispose();
  }

  String subject = "";

  var ques = "";
  var c_ans = "";
  var w_ans1 = "";
  var w_ans2 = "";
  var w_ans3 = "";

  clearText(
      String ques, String w_ans1, String w_ans2, String w_ans3, String c_ans) {
    quesController.clear();
    c_ansController.clear();
    w_ans1Controller.clear();
    w_ans2Controller.clear();
    w_ans3Controller.clear();
  }

  final quesController = TextEditingController();
  final c_ansController = TextEditingController();
  final w_ans1Controller = TextEditingController();
  final w_ans2Controller = TextEditingController();
  final w_ans3Controller = TextEditingController();

  Future<void> addQuestion() async {
    await    FirebaseFirestore.instance.collection('classes').doc('${widget.Clsid}')
        .collection('S').doc("${widget.Sid}").collection('T').doc('${widget.tid}').collection('QNA')
        .add({
          'ques': ques,
          'c_ans': c_ans,
          'w_ans1': w_ans1,
          'w_ans2': w_ans2,
          'w_ans3': w_ans3,
        })
        .then((value) => print('Question Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Padding(
          padding: EdgeInsets.only(top:14.0),
          child: Text('Add Questions', style:GoogleFonts.stylish(textStyle: TextStyle(
            fontSize: 34,
          ))),
        ),
      automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                        color: Palette.skyblue),
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
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

                           const SizedBox(height: 17,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      ques = quesController.text;
                                      c_ans = c_ansController.text;
                                      w_ans1 = w_ans1Controller.text;
                                      w_ans2 = w_ans2Controller.text;
                                      w_ans3 = w_ans3Controller.text;
                                      addQuestion();
                                      clearText(
                                          ques, w_ans1, w_ans2, w_ans3, c_ans);
                                      _showToast(context,'Question added!');
                                    });
                                  }
                                },
                                child:  Text(
                                  'Add',
                                    style:GoogleFonts.stylish(textStyle: TextStyle(
                                      fontSize: 24,
                                    ))
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  clearText(
                                      ques, w_ans1, w_ans2, w_ans3, c_ans),
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                child:  Text(
                                  'Reset',
                                    style:GoogleFonts.stylish(textStyle: TextStyle(
                                      fontSize: 24,
                                    ))
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
              style: TextStyle(fontSize: 18,fontFamily: 'Comfortaa')),
        ],
      ),
    ),
  );
}
