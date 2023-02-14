import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme:Theme.of(context);
    return  Scaffold(
        body: AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback here',
                filled: true,
              ),
              maxLines: 5,
              maxLength: 4096,
              textInputAction: TextInputAction.done,
              validator: (String? text) {
                if (text == null || text.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Send',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String message;
                  try {
                    final collection = FirebaseFirestore.instance.collection('feedback');
                    await collection.doc().set({
                      'timestamp': FieldValue.serverTimestamp(),
                      'feedback': _controller.text,
                    });
                    message = 'Feedback Sent!';
                  } catch (e) {
                    message = 'Error when sending feedback';
                  }
                  Fluttertoast.showToast(
                      msg: "$message",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER_RIGHT,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.black26,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                  Navigator.pop(context);
                }
              },
            )
          ], shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16, )),
        ),
      );
  }
}