

import 'package:babysitter/screens/welcome_screen.dart';
import 'package:babysitter/utils/size_config.dart';

import 'package:babysitter/utils/app_theme.dart';

import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _configureAmplify() async {

    try{


      await Amplify.addPlugins([

        AmplifyAuthCognito(),

      ]);

      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);

      if(Amplify.isConfigured) {

      }else{
        print("Amplify not configured");
      }

    } catch(e) {
      print('an error occured during amplify configuration: $e');



    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Babysitter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'RobotoMono',
        appBarTheme: AppBarTheme(backgroundColor: ThemeColor.primaryColor,iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),),
        primaryColor: const Color(0xFFfcce01), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0XFFd6ecff))
      ),

      home: WelcomeScreen()



    );
  }
}


