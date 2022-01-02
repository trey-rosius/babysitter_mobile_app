import 'package:babysitter/components/button.dart';
import 'package:babysitter/screens/login/login_screen.dart';
import 'package:babysitter/screens/profiles/create_nanny_profile_screen.dart';
import 'package:babysitter/screens/profiles/profile_repository.dart';
import 'package:babysitter/screens/select_user_type.dart';
import 'package:babysitter/utils/app_theme.dart';
import 'package:babysitter/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import 'login/otp_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);



  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}



class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(800),child: Container(

        padding: EdgeInsets.all(20),
        child: const SafeArea(child:  Text('Babysitter', textAlign:TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
      ),),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/baby_sitter.svg',

                height: 250,
                width: 250,
                fit: BoxFit.cover,



              ),

              Stack(

                children: [

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: size.height/6),
                      width: size.width,
                      height: size.height/2.2,

                      decoration: const BoxDecoration(
                          color: ThemeColor.primaryColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(100),topRight: Radius.circular(100))
                      ),

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black,width: 1),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                          child: const Text('Entrust your beloved family care with us',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                          child: const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type speci",style: TextStyle(),),
                        ),

                        InkWell(
                          onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> SelectUserTypeScreen()));


                          },
                            child: Button('Get Started', size))
                      ],
                    ),

                  ),
                ],
              )

            ],
          )
      ),

    );
  }
}
