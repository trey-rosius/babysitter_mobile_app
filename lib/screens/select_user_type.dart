import 'package:babysitter/components/button.dart';
import 'package:babysitter/screens/login/login_screen.dart';
import 'package:babysitter/screens/login/register_screen.dart';
import 'package:babysitter/utils/size_config.dart';
import 'package:flutter/material.dart';

class SelectUserTypeScreen extends StatelessWidget {
  const SelectUserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: PreferredSize(preferredSize: Size.fromHeight(800),child: Container(

        padding: EdgeInsets.all(20),
        child: const SafeArea(child:  Text('Select Role', textAlign:TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
      ),),
      body: SingleChildScrollView(child: Container(

        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding:  EdgeInsets.only(bottom: 10),
                  child: Text('Choose Role',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Text('Start by choosing your role'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context){

                   return RegisterScreen('parent');


                 }));
               },
               child: Card(

                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                      child: ListTile(

                        title: Text("I'm a parent"),
                        subtitle: Text('I need help,looking after my kids'),
                        trailing: Icon(Icons.forward)
                      ),
                    ),
                  ),
             ),
             Container(
               padding: EdgeInsets.only(top: 20),
               child: InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context){

                     return RegisterScreen('nanny');


                   }));
                 },
                 child: Card(

                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        child: ListTile(
                          title: Text("I'm a nanny"),
                          subtitle: Text('I can help look after your kids'),
                          trailing: Icon(Icons.forward)
                        ),
                      ),
                    ),
               ),
             ),

            ],),
          ),
            Container(
              padding: EdgeInsets.only(top: size.height/10),
              child: Text('OR'),
            ),
            Container(
              padding: EdgeInsets.only(top: size.height/15),
              child: Text('Already have an account ?'),
            ),
             InkWell(
                 onTap:(){
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                     return  LoginScreen();
                   }));
                 },
                 child: Button('Log In',size))
        ],),
      ),),
    );
  }
}
