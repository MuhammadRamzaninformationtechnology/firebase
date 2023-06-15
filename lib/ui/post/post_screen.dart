import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
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
    );
  }
}
