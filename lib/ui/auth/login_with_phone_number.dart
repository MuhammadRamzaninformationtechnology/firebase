import 'package:firebase/Utils_firebase/Utils.dart';
import 'package:firebase/ui/auth/verify_number.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading= false;
  final phonenumbercontroller = TextEditingController();
  final auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80),
            TextFormField(
              controller: phonenumbercontroller,
              decoration: const InputDecoration(
                hintText: 'Phone',
                border: OutlineInputBorder(),
                labelText: 'Phone',
                helperText: '+92000,0000000',
                prefixIcon: Icon(Icons.phone_android_outlined),
              ),
            ),
            SizedBox(height: 80),
         RoundButton(title: "Login", ontap: (){
           auth.verifyPhoneNumber(
             phoneNumber: phonenumbercontroller.text,
               verificationCompleted: (_){},
               verificationFailed: (e){
               Utils().toastMessage(e.toString());
               },
               codeSent: (String verificaionId,int? token){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCodeScreen(verificaion: verificaionId,)));

               },
               codeAutoRetrievalTimeout: (e){
                 Utils().toastMessage(e.toString());

               }
               );

         })
          ],
        ),
      ),
    );
  }
}
