import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback ontap;
  final bool loading;
   RoundButton({super.key,required this.title,required this.ontap,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Center(
        child: loading? CircularProgressIndicator() : Text(title,style: TextStyle(color: Colors.white),),
      ),
      ),
    );
  }
}
