import 'package:firebase/Utils_firebase/Utils.dart';
import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/post/add_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref= FirebaseDatabase.instance.ref('post');
  final  serachtext= TextEditingController();
  final editController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Screen'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: serachtext,
               decoration:const InputDecoration(
                 hintText: "Search...",
                 suffix: Icon(Icons.search_outlined),
                 border: OutlineInputBorder(),
               ),
              onChanged: (String value){
                setState(() {

                });

              },

            ),
          ),

          Expanded(
            child: FirebaseAnimatedList(
                query:ref ,
                defaultChild: Text("loading"),
                itemBuilder: (context,snapshot,animation,index){
                  final title= snapshot.child('title').value.toString();
                  if(serachtext.text.isEmpty){
                    return ListTile(

                      title:Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                      trailing: PopupMenuButton(
                        icon:Icon(Icons.more_vert_outlined),
                        itemBuilder: (context)=>[
                          PopupMenuItem(
                            value: 1,

                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  showMyDialog(title,snapshot.child("id").value.toString());
                                },
                                leading: Icon(Icons.edit),
                                title: Text("Edit"),

                              )
                          ),
                          PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: (){
                                  Navigator.pop(context);
                                  ref.child(snapshot.child("id").value.toString()).remove();
                                },
                                leading: Icon(Icons.delete_rounded),
                                title: Text("Delete"),


                              )
                          ),
                        ],
                      ),
                    );
                  }else if(title.toLowerCase().contains(serachtext.text.toLowerCase())){
                    return ListTile(

                      title:Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  }else{
                    return Container();
                  };

    }),
          ),

        ],
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));

        },child: Icon(Icons.add),
        ),
    );
  }

  Future<void> showMyDialog(String title,String id)async{
    editController.text=title;

    return showDialog(
      context: context,
      builder: (BuildContext context){
      return AlertDialog(
        title:Text("Update"),
        content: Container(
          child: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Edit',

            ),
          ),

        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel")),
          TextButton(onPressed: (){
            Navigator.pop(context);
            ref.child(id).update({
              "title":editController.text.toString(),
            }).then((value) {
            Utils().toastMessage("Post Updated");

            }).onError((error, stackTrace){
               Utils().toastMessage(error.toString());
            });
          }, child: Text("Update")),
        ],
      );
      }
    );
  }

}


// =========================================
// Expanded(
// child: StreamBuilder(
// stream: ref.onValue,
// builder: (context,AsyncSnapshot<DatabaseEvent>snapshot){
// Map<dynamic, dynamic>map=snapshot.data!.snapshot.value as dynamic;
// if(!snapshot.hasData){
// return CircularProgressIndicator();
// }else{
// List<dynamic>list=[];
// list.clear();
// list =map.values.toList();
// return ListView.builder(
// itemCount: snapshot.data!.snapshot.children.length,
// itemBuilder: (
// context,index){
// return ListTile(
// title: Text(list[index]["title"]),
// subtitle: Text(list[index]["id"]),
// );
// }
// );
// }
//
// },
// )
// ),