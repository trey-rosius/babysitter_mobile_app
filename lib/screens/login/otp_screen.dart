
import 'package:babysitter/components/button.dart';
import 'package:babysitter/screens/profiles/create_nanny_profile_screen.dart';
import 'package:babysitter/screens/profiles/profile_repository.dart';
import 'package:babysitter/utils/app_theme.dart';
import 'package:babysitter/utils/validations.dart';
import 'package:flutter/material.dart';

import 'package:babysitter/utils/size_config.dart';


import 'package:provider/provider.dart';

import 'login_repository.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({required this.username,required this.password,required this.email,required this.groupName});
  final String username;
  final String password;
  final String email;
  final String groupName;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: const Text("OTP Screen",style: TextStyle(color: Colors.black),),
        ),
        body: ChangeNotifierProvider.value(
            value: LoginRepository.instance(),
            child: Consumer(builder: (_, LoginRepository loginRepo, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                  controller: loginRepo.codeController,
                                  obscureText: loginRepo.obscureText,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeColor.primaryColor,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:(Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.toWidth,
                                      vertical: 20.toHeight,
                                    ),
                                    hintText: 'Please enter OTP Code',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15.toFont,
                                      fontWeight: FontWeight.w500,
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
                                      labelText: 'OTP Code',

                                      labelStyle: TextStyle(color: ThemeColor.black)
                                  ),
                                  validator: (value) =>
                                      Validations.validateOTP(value!)),
                            ),
                            loginRepo.loading? Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(20),
                              child: const Center(child: CircularProgressIndicator()),
                            ) :  InkWell(
                              onTap: (){
    if (_formKey.currentState!.validate()) {
      loginRepo.confirmUser(widget.username,widget.password,widget.email, widget.groupName).then((bool value) {
        if(value){

          Navigator.push(context, MaterialPageRoute(builder:(context)=>
              ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                  child: CreateNannyProfileScreen(username: loginRepo.usernameController.text,))));

        }else{
          print("couldn't Sign User In");
        }
      });
    }

                              },
                                child: Button('confirm account',size))
                          ],
                        ),

                      )),
                ],
              );
            })));
  }
}
