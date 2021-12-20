
import 'dart:io';
import 'dart:ui';
import 'package:babysitter/components/button.dart';
import 'package:babysitter/utils/app_theme.dart';
import 'package:babysitter/utils/date_manipulations.dart';
import 'package:babysitter/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_repository.dart';

class CreateNannyProfileScreen extends StatefulWidget {



  @override
  _CreateNannyProfileScreenState createState() => _CreateNannyProfileScreenState();
}

class _CreateNannyProfileScreenState extends State<CreateNannyProfileScreen> {

  XFile? _imageFile;
  dynamic _pickImageError;

  final ImagePicker _picker = ImagePicker();
  File? file;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();




  //Future<File> _imageFile;
  DateTime selectedDate = DateTime(2003);

  Future<Null> _selectDate(BuildContext context,ProfileRepository profileRepository) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960),
        lastDate: DateTime(2003));
    if (picked != null && picked != selectedDate)

        profileRepository.day = picked.day;
        profileRepository.month = picked?.month;
        profileRepository.year = picked?.year;
        selectedDate = picked!;
        print(picked.day.toString());
        print(picked.month.toString());
        print(picked.year.toString());
        profileRepository.dateOfBirthController.text = '${picked.day} / ${picked.month} / ${picked.year}';
    bool leapYear =
    DateManipulations().checkLeapYear(selectedDate.year);

    String age = DateManipulations().calculateDob(picked.toString(), leapYear);
    print("You're " +age+" yrs old");
    profileRepository.age = int.parse(age);

  }




  String? _retrieveDataError;






  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImage(ProfileRepository profileRepo, BuildContext context) {

    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform

        return Container(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              _imageFile!.path,
              height: 100,
              width: 100,
            ),
          ),
        );

      } else {

        return Container(
          child: Semantics(
              child: Image.file(
                File(_imageFile!.path),
                width: 100,
              ),
              label: 'pick image'),
        );

      }
    } else if (_pickImageError != null) {

      print("error occured during image pick");

      return InkWell(
        onTap: () {
          _onImageButtonPressed(ImageSource.gallery, context, profileRepo);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.account_circle,
              size: 100,
              color: ThemeColor.primaryColor,
            )),
      );

    } else {


      return InkWell(
        onTap: () {
          _onImageButtonPressed(ImageSource.gallery, context, profileRepo);
        },
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.account_circle,
              size: 100,
              color: ThemeColor.primaryColor,
            )),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  void _onImageButtonPressed(ImageSource source, BuildContext context,
      ProfileRepository profileRepo) async {
    profileRepo.loading = true;

    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );

      var dir = await path_provider.getTemporaryDirectory();
      var targetPath = dir.absolute.path + "/temp.jpg";
      setState(() {
        _imageFile = pickedFile;
      });

      await profileRepo.cropImage(
          _imageFile!.path, context, targetPath);

    } catch (e) {
      // profileRepo.loading = false;

      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    var profileRepo = context.read<ProfileRepository>();
/*
    profileRepo.retrieveEmail().then((String email){
      print("Email is"+ email);
      profileRepo.email = email;
    });
    profileRepo.retrieveCurrentUser().then((AuthUser authUser) {
      print(authUser.username);
      print(authUser.userId);
      profileRepo.userId = authUser.userId;
      profileRepo.username = authUser.username;
    });
    */
   profileRepo.getCurrentPosition();

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var profileRepo = context.watch<ProfileRepository>();

    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('create profile ',style: TextStyle(color: Colors.black),),

        ),

      body: SingleChildScrollView(
        child:  Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              profileRepo.loading
                  ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
                  : InkWell(
                  onTap: () {
                    _onImageButtonPressed(ImageSource.gallery, context, profileRepo);
                  },
                  child: profileRepo.profilePic.isEmpty
                      ?
                  _previewImage(profileRepo, context)

                      : Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: ClipOval(
                            child: ClipRRect(
                                borderRadius:
                                new BorderRadius.circular(
                                    30),
                                child: CachedNetworkImage(
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                    imageUrl: profileRepo
                                        .profilePic,
                                    placeholder: (context,
                                        url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context,
                                        url, ex) =>
                                        CircleAvatar(
                                          backgroundColor:
                                          Theme.of(
                                              context)
                                              .colorScheme.secondary,
                                          radius: 40.0,
                                          child: Icon(
                                            Icons
                                                .account_circle,
                                            color:
                                            Colors.white,
                                            size: 40.0,
                                          ),
                                        )))),
                      ))

                // child: _prev,

              ),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                  Row(
                    children: [
                      Flexible(
                        child: Container(

                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(

                            controller: profileRepo.firstNamesController,
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
                              labelText: 'first name',

                              labelStyle: TextStyle(color: ThemeColor.black),
                              hintText: "first name",
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15.toFont,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(

                          margin: const EdgeInsets.only(top: 20,left: 10),
                          child: TextFormField(

                            controller: profileRepo.lastNamesController,
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
                              labelText: 'last name',

                              labelStyle: TextStyle(color: ThemeColor.black),
                              hintText: "last name",
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15.toFont,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                    Container(

                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(

                        controller: profileRepo.aboutController,
                        maxLines: 3,
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
                          labelText: 'about me',

                          labelStyle: TextStyle(color: ThemeColor.black),
                          hintText: "about me",
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15.toFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'about me';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),

                      child: TextFormField(
                          maxLines: 2,
                        controller: profileRepo.addressController,
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
                          labelText: 'address',

                          labelStyle: TextStyle(color: ThemeColor.black),
                          hintText: "address",
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15.toFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'address';
                          }
                          return null;
                        },
                      ),
                    ),

                    InkWell(
                      onTap:(){
                        _selectDate(context,profileRepo);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                           vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My date of birth is ..",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              margin:
                              EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1),
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  profileRepo.dateOfBirthController.text
                                      .isEmpty
                                      ? Text(
                                    "DD/MM'YYYY",
                                    style:
                                    TextStyle(fontSize: 20),
                                  )
                                      : Text(
                                      profileRepo
                                          .dateOfBirthController
                                          .text,
                                      style:
                                      TextStyle(fontSize: 20)),
                                  Icon(Icons.calendar_today)
                                ],
                              ),
                            ),
                            Text(
                              "You are "+profileRepo.age.toString()+" yrs old",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I am a..",
                            style: TextStyle(
                                fontSize: 17, color: Colors.black),
                          ),
                          Container(
                            margin:
                            EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:(){
                                    //profileRepo.onSexSelected();

                                  },
                                  child: Container(

                                    margin: EdgeInsets.only(right: 20),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: profileRepo.male ? Colors.red : Colors.grey,
                                            width: 1),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/images/male.svg',

                                        height: 24,
                                        width: 24,
                                        fit: BoxFit.cover,



                                      ),

                                      Container(

                                          padding:
                                          EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Male",
                                            style:
                                            TextStyle(fontSize: 20),
                                          ))
                                    ]),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                   // profileRepo.onSexSelected(),
                                  },
                                  child: Container(

                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: profileRepo.female ? Colors.red : Colors.grey,
                                            width: 1),
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                        'assets/images/female.svg',

                                        height: 24,
                                        width: 24,
                                        fit: BoxFit.cover,



                                      ),

                                      Container(

                                          padding:
                                          EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Female",
                                            style:
                                            TextStyle(fontSize: 20),
                                          ))
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),




              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: <Widget>[
                    profileRepo.loading? Container(
                      padding: EdgeInsets.only(top: 30.0),

                      child: CircularProgressIndicator(),
                    ) :

                   InkWell(
                       onTap: (){

                         final FormState form = formKey.currentState!;
                         if (!form.validate()) {

                         } else {
                           form.save();

                           if(profileRepo.age <=0){
                             profileRepo.showInSnackBar(context,"date of birth is empty");
                             return;
                           }



                           print(profileRepo.profilePic);
                           print(profileRepo.firstNamesController.text);
                           print(profileRepo.lastNamesController.text);

/*

                                          profileRepo.saveUserProfileDetails().then((_){

                                            print("save to database");
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return MultiProvider(
                                                providers: [
                                                  ChangeNotifierProvider(create: (_) => ProfileRepository.instance(),),
                                                  ChangeNotifierProvider(create: (_) => PostRepository.instance(),),
                                                  ChangeNotifierProvider(create: (_) => SharedPrefsUtils.instance(),),

                                                ],
                                                child:HomePage(),

                                              );
                                            }));

                                          });

*/


                         }

                       },
                       child: Button('save profile information',screenSize))

                  ],
                ),
              )

            ],
          ),
        ),
      )

    );
  }
}
