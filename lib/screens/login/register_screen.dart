
import 'dart:ui';

import 'package:babysitter/components/button.dart';
import 'package:babysitter/utils/app_theme.dart';
import 'package:babysitter/utils/size_config.dart';
import 'package:babysitter/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_repository.dart';
import 'otp_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(value: LoginRepository.instance(),
        child: Consumer(builder: (_,LoginRepository loginRepo,child){
         return Scaffold(
           appBar: AppBar(
             centerTitle: true,
             elevation: 0,
             title: Text('create account',style: TextStyle(color: Colors.black),),



           ),
           body:  SingleChildScrollView(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   padding: EdgeInsets.only(left: 20),
                   child: Text("choose user type",style: TextStyle(fontSize: 16),),),
                 Container(
                   padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       InkWell(
                         onTap: (){
                           if(loginRepo.isParent){

                           }else{
                             loginRepo.groupName = 'parent';
                             loginRepo.isParent = true;
                             loginRepo.isNanny = false;
                           }
                         },
                         child: Container(
                           width: size.width/3,
                           height: size.height/16,

                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8.0),
                             border: Border.all(color: Colors.black,width: 1),
                             color: loginRepo.isParent ?ThemeColor.color1 :Colors.grey[200],
                             boxShadow: loginRepo.isParent ?  [
                               const BoxShadow(
                                 color: Colors.black,
                                 blurRadius: 2.0,
                                 spreadRadius: 0.0,
                                 offset: Offset(2.0, 2.0), // shadow direction: bottom right
                               )
                             ] :[],
                           ),
                           child:  Center(child: Text('Parent')),
                         ),
                       ),
                       InkWell(

                           onTap: () {
                             if (loginRepo.isNanny) {

                             } else {
                               loginRepo.isParent = false;
                               loginRepo.isNanny = true;
                               loginRepo.groupName = 'nanny';
                             }


                         },
                         child:  Container(
                           width: size.width/3,
                           height: size.height/16,

                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8.0),
                             border: Border.all(color: Colors.black,width: 1),
                             color: loginRepo.isNanny ?ThemeColor.color1 :Colors.grey[200],
                               boxShadow: loginRepo.isNanny ?  [
                               const BoxShadow(
                                 color: Colors.black,
                                 blurRadius: 2.0,
                                 spreadRadius: 0.0,
                                 offset: Offset(2.0, 2.0), // shadow direction: bottom right
                               )
                               ] :[]

                           ),
                           child:  Center(child: Text('Nanny')),
                         ),
                       ),
                     ],
                   ),
                 ),
                 Container(

                   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                   decoration: BoxDecoration( color: ThemeColor.cardBackground, border: Border.all(color: Colors.black,width:2),
                     borderRadius: BorderRadius.all(
                       Radius.circular(10.toWidth),
                     ),


                     ),
                   child: Form(
                       key: _formKey,
                       child: Container(

                         child: Column(

                           children: <Widget>[

                             Container(


                               child: TextFormField(


                                 controller: loginRepo.usernameController,
                                 autocorrect: false,

                                 style: TextStyle(color: Colors.black),
                                 decoration: InputDecoration(
                                    fillColor: Colors.white,
                                     filled: true,
                                     border: OutlineInputBorder(
                                       borderSide: BorderSide(color: (Colors.black), width: 1.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),

                                     ),
                                     enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: ThemeColor.primaryColor, width: 1.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),
                                     ),
                                     disabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: (Colors.grey[700])!, width: 1.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),
                                     ),

                                     hintText: "username",
                                     hintStyle: TextStyle(
                                       color: Colors.grey[600],
                                       fontSize: 15.toFont,
                                       fontWeight: FontWeight.w500,
                                     ),
                                     labelText: 'username',

                                     labelStyle: TextStyle(color: ThemeColor.black)
                                 ),
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Please enter a username';
                                   }
                                   return null;
                                 },
                               ),
                             ),

                             Container(
                               padding: EdgeInsets.symmetric(vertical: 10),
                               child: TextFormField(
                                 controller: loginRepo.emailController,
                                 autocorrect: false,


                                 style: TextStyle(color: Colors.black),
                                 decoration: InputDecoration(
                                   fillColor: Colors.white,
                                   filled: true,
                                   border: OutlineInputBorder(
                                     borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(10.toWidth),
                                     ),
                                   ),
                                   enabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(10.toWidth),
                                     ),
                                   ),
                                   focusedBorder: OutlineInputBorder(
                                     borderSide: BorderSide(color: ThemeColor.primaryColor, width: 2.toWidth),
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(10.toWidth),
                                     ),
                                   ),
                                   disabledBorder: OutlineInputBorder(
                                     borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                     borderRadius: BorderRadius.all(
                                       Radius.circular(10.toWidth),
                                     ),
                                   ),

                                   hintText: 'email',
                                   hintStyle: TextStyle(
                                     color: Colors.grey[600],
                                     fontSize: 15.toFont,
                                     fontWeight: FontWeight.w500,
                                   ),
                                     labelText: 'email',

                                     labelStyle: TextStyle(color: ThemeColor.black)
                                 ),
                                 validator: (value) =>  Validations.validateEmail(value!),
                               ),
                             ),
                             Container(
                               padding: EdgeInsets.symmetric(vertical: 10),
                               child: TextFormField(
                                   controller: loginRepo.passwordController,
                                   obscureText: loginRepo.obscureText,
                                   style: TextStyle(color: Colors.black),
                                   decoration: InputDecoration(
                                     fillColor: Colors.white,
                                     filled: true,
                                     border: OutlineInputBorder(
                                       borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),
                                     ),
                                     enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),
                                     ),
                                     focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: ThemeColor.primaryColor, width: 2.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),
                                     ),
                                     disabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: (Colors.grey[700])!, width: 2.toWidth),
                                       borderRadius: BorderRadius.all(
                                         Radius.circular(10.toWidth),
                                       ),
                                     ),
                                       suffixIcon: IconButton(
                                         color: Colors.black,
                                         icon: Icon(
                                           loginRepo.obscureText ? Icons.visibility : Icons.visibility_off,
                                         ),
                                         onPressed: () {
                                           loginRepo.obscureText = !loginRepo.obscureText;

                                         },
                                       ),

                                     hintText: 'password',
                                     hintStyle: TextStyle(
                                       color: Colors.grey[600],
                                       fontSize: 15.toFont,
                                       fontWeight: FontWeight.w500,
                                     ),
                                       labelText: 'password',

                                       labelStyle: TextStyle(color: ThemeColor.black)
                                   ),
                                   validator: (value) =>  Validations.validatePassword(value!)
                               ),
                             ),


                             loginRepo.loading? Container(
                               padding: EdgeInsets.all(10),
                               margin: EdgeInsets.all(20),
                               child: Center(child: CircularProgressIndicator()),
                             ) :  InkWell(
                                 onTap: (){
                                   if (_formKey.currentState!.validate()) {
                                     loginRepo.register(context).then((bool? value){

                                       if(loginRepo.isSignUpComplete) {
                                         Navigator.push(context, MaterialPageRoute(builder: (context){
                                           return OtpScreen(username: loginRepo.usernameController.text.trim(),
                                             password: loginRepo.passwordController.text.trim(),
                                             email:loginRepo.emailController.text.trim(),groupName: 'Nanny',);
                                         }));
                                       }else{

                                       }


                                     });

                                   }
                                 },
                                 child: Button('create account',size)),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 const Text("Already have an account ?",style: TextStyle(color: Colors.black),),
                                 TextButton(onPressed: (){
                                   Navigator.of(context).pop();
                                   Navigator.push(context, MaterialPageRoute(builder: (context){
                                     return OtpScreen(username: "asdasdasd",
                                       password: "asdasdasd",
                                       email:"asdasdasd",groupName: 'Nanny',);
                                   }));
                                 }, child: const Text("log in",style: TextStyle(color:ThemeColor.color1,fontWeight: FontWeight.bold,fontSize: 17),))
                               ],
                             )

                           ],
                         ),
                       )),
                 ),
               ],
             ),
           )

         );
        },),

    );
  }
}
