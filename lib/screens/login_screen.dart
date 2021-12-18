
import 'package:babysitter/components/image_button.dart';
import 'package:babysitter/utils/app_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {




  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: PreferredSize(preferredSize: Size.fromHeight(800),child: Container(


        padding: EdgeInsets.all(20),
        child: const SafeArea(child:  Text('Login', textAlign:TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
      ),),
      body:

          Center(
            child: Stack(
              alignment:Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: size.width,


                    color: ThemeColor.primaryColor,
                    padding: EdgeInsets.all(10),
                    child: Text("Terms and Conditions @2022",textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),),
                ),
                Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      ImageButton('login with google',size,'assets/images/google.svg',Color(0xFFde5246)),
                      ImageButton('login with apple',size,'assets/images/apple.svg',Color(0xFF000000)),
                      ImageButton('login with facebook',size,'assets/images/facebook.svg',Color(0xFF3b5998)),
                    ],
                  ),
                ),

                Container(
                  height: size.height/5,

                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Already Have an Account ? "),
                      Text("LOGIN"),
                    ],
                  )

                  ),

              ],
            ),
          ),




    );
  }
}
