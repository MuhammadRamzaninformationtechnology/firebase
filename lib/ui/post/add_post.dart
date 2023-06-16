import 'package:firebase/Utils_firebase/Utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
   final postController= TextEditingController();
   bool loading =false;
  final databaseref= FirebaseDatabase.instance.ref("post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add post'),
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
            RoundButton(title: "Add",loading: loading, ontap: (){

              setState(() {
                loading=true;
              });
              String id= DateTime.now().microsecondsSinceEpoch.toString();
              databaseref.child(id).set({
                'title': postController.text.toString(),
                'id':id,
              }).then((value){
                    Utils().toastMessage("Add the Data");
                    setState(() {
                      loading=false;
                    });
              }).onError((error, stackTrace){
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
