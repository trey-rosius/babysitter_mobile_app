import 'package:babysitter/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ImageButton extends StatelessWidget {
  ImageButton(this.title,this.size,this.svgImage,this.color);
  final String title;
  final Size size;
  final String svgImage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(

      width: size.width,
      height: size.height/10,





      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 20,
            left: 40,
            child: Container(

              width: size.width/1.2,
              height: size.height/16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black,width: 1),
                color: ThemeColor.tertiaryColor,

              ),



            ),
          ),
          Container(
            width: size.width/1.2,
            height: size.height/16,
            padding: EdgeInsets.symmetric(horizontal: 10),


            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black,width: 1),
              color: color,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            child:  Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  svgImage,

                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                    color: Colors.white


                ),
                Text(title,style: TextStyle(color: Colors.white),),
              ],
            )),
          ),

        ],),

    );
  }
}
