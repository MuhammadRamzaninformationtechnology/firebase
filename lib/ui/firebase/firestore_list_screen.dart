import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Utils_firebase/Utils.dart';
import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/firebase/add_firebase_data.dart';
import 'package:firebase/ui/post/add_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {


  final auth = FirebaseAuth.instance;

  final editController= TextEditingController();
  final fireStore= FirebaseFirestore.instance.collection("user").snapshots();
  CollectionReference ref= FirebaseFirestore.instance.collection("user");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            });

          }, icon: Icon(Icons.login_outlined))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
        StreamBuilder<QuerySnapshot>(
          stream: fireStore,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

            if(snapshot.connectionState==ConnectionState.waiting){
              return const CircularProgressIndicator();
            }if(snapshot.hasError){
              return const  Text('Some error');

            }
            return  Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context ,index){
                    return ListTile(
                      onTap: (){
                        ref.doc(snapshot.data!.docs[index]["id"].toString()).delete();
                      },
                      title: Text( snapshot.data!.docs[index]["title"].toString()),
                      subtitle: Text( snapshot.data!.docs[index]["id"].toString()),

                    );
                  }),
            );

            }
        ),


        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFirebaseDataScreen()));

        },child: Icon(Icons.add),
      ),
    );
  }

  // Future<void> showMyDialog(String title,String id)async{
  //   editController.text=title;
  //
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //           title:Text("Update"),
  //           content: Container(
  //             child: TextField(
  //               controller: editController,
  //               decoration: InputDecoration(
  //                 hintText: 'Edit',
  //
  //               ),
  //             ),
  //
  //           ),
  //           actions: [
  //             TextButton(onPressed: (){
  //               Navigator.pop(context);
  //             }, child: Text("Cancel")),
  //             TextButton(onPressed: (){
  //               Navigator.pop(context);
  //
  //             }, child: Text("Update")),
  //           ],
  //         );
  //       }
  //   );
  // }

}
