import 'package:firebase/Utils_firebase/Utils.dart';
import 'package:firebase/ui/post/post_screen.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {

 final  String verificaion;
  const VerifyCodeScreen({super.key,required this.verificaion});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading= false;
  final verificationCodeController = TextEditingController();
  final auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 80),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '6 Digit code',
                border: OutlineInputBorder(),
                labelText: 'Code',
                helperText: '123,456',
                prefixIcon: Icon(Icons.verified_user_outlined),
              ),
            ),
            SizedBox(height: 80),
            RoundButton(title: "Verify",loading: loading, ontap: ()async{
              setState(() {
                loading=true;
              });
          final credital= PhoneAuthProvider.credential(
              verificationId: widget.verificaion,
              smsCode: verificationCodeController.text.toString()
          );
          try{
            await auth.signInWithCredential(credital);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));

          }catch(e){
            setState(() {
              loading=false;
            });
            Utils().toastMessage(e.toString());
          }


            })
          ],
        ),
      ),
    );
  }
}


