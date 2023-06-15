import 'dart:ffi';

import 'package:firebase/Utils_firebase/Utils.dart';
import 'package:firebase/ui/auth/Signup_screen.dart';
import 'package:firebase/ui/auth/login_with_phone_number.dart';
import 'package:firebase/ui/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false ;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _Auth= FirebaseAuth.instance;




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
setState(() {
  loading=true;

});
    _Auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
      Utils().toastMessage(value.user.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen())
        );
     setState(() {
       loading=false;
     });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
    Utils().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          helperText: 'Enter the email e.g jon@gmail.com',
                          prefixIcon: Icon(Icons.alternate_email_outlined),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return'Enter the Email';
                          }return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,

                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          helperText: 'Enter the password 6 e.g 123456',
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return'Enter the Password';
                          }return null;
                        },

                      ),
                    ],
                  )),
             const SizedBox(height: 50),
              RoundButton(
                title: 'Login',
                loading: loading,
                ontap: () {

                  if(formkey.currentState!.validate()){
                    login();
                  }
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                  },
                      child: Text('Sign up'))
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber()));

               },
                child: Container(
                height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                   border: Border.all(
                     color:  Colors.black,
                   )
                  ),
                  child:  Text('Login with Phone NO'),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
