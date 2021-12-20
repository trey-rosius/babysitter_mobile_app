import 'dart:ui';
import 'package:babysitter/components/button.dart';
import 'package:babysitter/components/image_button.dart';
import 'package:babysitter/screens/login/register_screen.dart';
import 'package:babysitter/utils/app_theme.dart';
import 'package:babysitter/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_repository.dart';

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in here");


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(create: (_)=> LoginRepository.instance(),
    child: Consumer(builder: (_,LoginRepository loginRep,child){
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('login',style: TextStyle(color: Colors.black),),

        ),
          body:


              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),



                      child: Form(
                          key: _formKey,
                          child: Container(


                            child: Column(
                              children: <Widget>[

                                Container(


                                  child: TextFormField(

                                    controller: loginRep.usernameController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,

                                      prefixIcon: Icon(Icons.account_circle,color:ThemeColor.color1),

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
                                      labelText: 'username',

                                      labelStyle: TextStyle(color: ThemeColor.black),
                                      hintText: "Please enter Username",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15.toFont,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: TextFormField(
                                    controller: loginRep.passwordController,
                                    obscureText: loginRep.obscureText,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixIcon: Icon(Icons.vpn_key,color:ThemeColor.color1),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color:(Colors.grey[700])!, width: 2.toWidth),
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
                                          loginRep.obscureText ? Icons.visibility : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          loginRep.obscureText = !loginRep.obscureText;

                                        },
                                      ),
                                      labelText: 'password',

                                      labelStyle: TextStyle(color: ThemeColor.black),
                                      hintText: 'Please enter a password',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 15.toFont,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                loginRep.loading? Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(20),
                                  child: const Center(child: CircularProgressIndicator()),
                                ) :  InkWell(
                                    onTap: (){
                                      if (_formKey.currentState!.validate()) {
                                        loginRep.login().then((bool isSignedIn){
                                          if(isSignedIn) {
                                            print("signed In");
                                            /*
                                                           loginRep.retrieveCurrentUser().then((AuthUser authUser) {

                                                             Navigator.push(context, MaterialPageRoute(builder: (context){
                                                               // return RegisterScreen();
                                                               //return LoginScreen();

                                                               return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                                                                 child: EditProfileScreen(authUser.userId),);


                                                             }));



                                                           });

*/


                                          }
                                        });

                                      }
                                    },
                                    child: Button('log in',size)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account ?",style: TextStyle(color:Colors.black),),
                                    TextButton(onPressed: (){
                                      /*
                                      Navigator.push(context, MaterialPageRoute(builder: (context){

                                       // return RegisterScreen();


                                      }));

                                       */
                                    }, child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,color: ThemeColor.color1),)),
                                  ],
                                )





                              ],
                            ),
                          )),
                    ),
                    Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          ImageButton('login with google',size,'assets/images/google.svg',Color(0xFFde5246)),
                         // ImageButton('login with apple',size,'assets/images/apple.svg',Color(0xFF000000)),
                          ImageButton('login with facebook',size,'assets/images/facebook.svg',Color(0xFF3b5998)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


          );

    },),);
  }
}
