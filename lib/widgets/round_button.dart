import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback ontap;
   RoundButton({super.key,required this.title,required this.ontap});

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
        child: Text(title,style: TextStyle(color: Colors.white),),
      ),
      ),
    );
  }
}
