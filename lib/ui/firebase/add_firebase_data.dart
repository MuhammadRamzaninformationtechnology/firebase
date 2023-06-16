import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Utils_firebase/Utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AddFirebaseDataScreen extends StatefulWidget {
  const AddFirebaseDataScreen({super.key});

  @override
  State<AddFirebaseDataScreen> createState() => _AddFirebaseDataScreenState();
}

class _AddFirebaseDataScreenState extends State<AddFirebaseDataScreen> {
  final postController= TextEditingController();
  bool loading =false;
  final firestore= FirebaseFirestore.instance.collection("user");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Firestore Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "What is in your mind",
                border: OutlineInputBorder(),

              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Add",
                loading: loading,
                ontap: (){
                  setState(() {
                    loading=true;
                  });
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                   firestore.doc(id).set({
                     "title":postController.text.toString(),
                     "id": id,

                   }).then((value) {
                     Utils().toastMessage("Add Post");
                     setState(() {
                       loading=false;
                     });
                   }).onError((error, stackTrace) {
                     Utils().toastMessage(error.toString());
                     setState(() {
                       loading=false;
                     });

                   });


            } )

          ],
        ),
      ),
    );
  }
}
