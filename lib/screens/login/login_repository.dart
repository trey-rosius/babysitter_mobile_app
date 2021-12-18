import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:babysitter/utils/confirm_signup_client_metadata.dart';
import 'package:babysitter/utils/shared_prefs.dart';
import 'package:babysitter/utils/signin_web_client_metadata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class LoginRepository extends ChangeNotifier{

  LoginRepository.instance();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  bool _isSignedIn = false;
  bool _loading = false;
  bool _obscureText = true;
  bool _isParent = true;
  bool _isNanny = false;
  String _groupName = 'parent';


  String get groupName => _groupName;

  set groupName(String value) {
    _groupName = value;
    notifyListeners();
  }

  bool get isParent => _isParent;

  set isParent(bool value) {
    _isParent = value;
    notifyListeners();
  }

  bool get isNanny => _isNanny;

  set isNanny(bool value) {
    _isNanny = value;
    notifyListeners();
  }

  bool get obscureText => _obscureText;

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  bool _googleLoading = false;

  bool _isOTPSignUpComplete = false;

  bool _isSignUpComplete = false;
  bool get isSignedIn => _isSignedIn;

  bool get isSignUpComplete => _isSignUpComplete;

  set isSignUpComplete(bool value) {
    _isSignUpComplete = value;
    notifyListeners();
  }

  set isSignedIn(bool value) {
    _isSignedIn = value;
    notifyListeners();
  }

  showSnackBar(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(child: Text(message,style: TextStyle(fontSize: 20),),)));
  }


  bool get isOTPSignUpComplete => _isOTPSignUpComplete;

  set isOTPSignUpComplete(bool value) {
    _isOTPSignUpComplete = value;
    notifyListeners();
  }

  bool get googleLoading => _googleLoading;

  set googleLoading(bool value) {
    _googleLoading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void>retrieveUserAttributes() async{
    try {
      var res = await Amplify.Auth.fetchUserAttributes();
      for (var element in res) {

        print('key: ${element.userAttributeKey}; value: ${element.value}');
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }
  Future<void>googleSignIn(BuildContext context) async{
    googleLoading = true;
    try {
      var res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google,options: SignInWithWebClientMetadata());

        isSignedIn = res.isSignedIn;
      if(isSignedIn){


        googleLoading = false;
        retrieveCurrentUser().then((AuthUser authUser) async{
          SharedPrefsUtils.instance().saveUserId(authUser.userId).then((value) {
            print("user id saved successfully");
          });
          print("User id is"+authUser.userId);





        });


      }else{
        googleLoading = false;
      }

    } on AmplifyException catch (e) {
      print(e.message);
      googleLoading = false;
    }



  }
  Future<AuthUser>retrieveCurrentUser() async{
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }
  Future<bool> login() async{
    loading = true;
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

        isSignedIn = res.isSignedIn;
        loading = false;
      if(isSignedIn){
        print("Google signed In");
        loading = false;

      }else{
        loading = false;
      }

      return isSignedIn;
    } on AuthException catch (e) {
      print(e.message);
      loading = false;
      return isSignedIn;
    }
  }
  Future<bool?> register(BuildContext context) async{
    loading =true;
    try {
      Map<String, String> userAttributes = {
        'email': emailController.text.trim(),
        'phone_number': '+15559101234',
        // additional attributes as needed
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          options: CognitoSignUpOptions(
              userAttributes: userAttributes,


          ),

      );

       print("is sign up complete" + res.isSignUpComplete.toString());
        isSignUpComplete = res.isSignUpComplete;
        loading =false;
       return isSignUpComplete;
    } on AuthException catch (e) {
      showSnackBar(context,e.message);
      print(e.message);
      loading =false;

    }
  }

  Future<bool> confirmUser(String username,String password,String email,String group) async {

    loading = true;

      SignUpResult res = await Amplify.Auth.confirmSignUp(username: username,

        confirmationCode: codeController.text.trim(),

        options: ConfirmSignUpClientMetadata( clientMetadata: {
          "group":group
        })
          );

        if(res.isSignUpComplete){
          print("Sign up is complete,now, sign in");
          SignInResult signInRes = await Amplify.Auth.signIn(
            username: username,
            password: password,
          );

          loading = false;
          return signInRes.isSignedIn;
        }else{
          loading = false;
          return isSignedIn;

        }



  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }


}