import 'package:babysitter/app_theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(this.title,this.size);
  final String title;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: size.width/1.5,
      height: size.height/8,




      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: Container(

              width: size.width/1.8,
              height: size.height/16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black,width: 1),
                color: AppTheme.secondaryColor,

              ),



            ),
          ),
          Container(
            width: size.width/1.8,
            height: size.height/16,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black,width: 1),
              color: AppTheme.primaryColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child:  Center(child: Text(title)),
          ),

        ],),

    );
  }
}
