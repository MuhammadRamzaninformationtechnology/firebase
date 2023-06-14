import 'package:firebase/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Utils_firebase/Utils.dart';
import '../../widgets/round_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void SignUp(){
    setState(() {
      loading = true;
    });
    firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString()).then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
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
              title: 'Sign Up',
              loading: loading,
              ontap: () {

                if(formkey.currentState!.validate()){

               SignUp();
                };
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account?"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                },
                    child: const Text('Login'))
              ],
            )

          ],
        ),
      ),
    );
  }
}
