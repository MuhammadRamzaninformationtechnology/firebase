
import 'dart:async';

import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SplashServices{

  void isLogin(BuildContext context){


    final auth= FirebaseAuth.instance;
    final user= auth.currentUser;


    if(user!=null){
      Timer(Duration(seconds: 3),
              ()=>Navigator.push(context, MaterialPageRoute(builder:(constext) =>PostScreen()))
      );
    }else{
      Timer(Duration(seconds: 3),
              ()=>Navigator.push(context, MaterialPageRoute(builder:(constext) =>LoginScreen()))
      );
    }


  }
}