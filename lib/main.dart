
import 'package:babysitter/screens/welcome_screen.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_api/amplify_api.dart';
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
        AmplifyAPI(),
        AmplifyStorageS3()

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
        appBarTheme: AppBarTheme(backgroundColor:Colors.transparent,elevation: 0,
          iconTheme: IconThemeData(
          color: Colors.black, //change your color here

        ),),
        primaryColor: const Color(0xFFfcce01), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0XFFd6ecff))
      ),

      home: WelcomeScreen()



    );
  }
}


