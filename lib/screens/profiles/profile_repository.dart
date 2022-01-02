import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:uuid/uuid.dart';

import 'package:amplify_api/amplify_api.dart';


class ProfileRepository extends ChangeNotifier {

  ProfileRepository.instance();



  final firstNamesController = TextEditingController();
  final lastNamesController = TextEditingController();
  final addressController = TextEditingController();
  final aboutController = TextEditingController();
  final dateOfBirthController = TextEditingController();



  S3UploadFileOptions? options;
  bool _loading = false;
  String _userId='';
  String _username='';
  String _email='';
  bool _logout = false;
  double _longitude = 0.0;
  double _latitude = 0.0;

  int _day =0;
  int _month =0;


  int _year=0;

  int _age = 0;


  int get age => _age;

  set age(int value) {
    _age = value;
    notifyListeners();
  }
  int get day => _day;

  set day(int value) {
    _day = value;
    notifyListeners();
  }

  bool _male = false;
  bool _female = true;


  bool get male => _male;

  set male(bool value) {
    _male = value;
    notifyListeners();
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
    notifyListeners();
  }

  String get email => _email;



  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }
  bool get logout => _logout;

  set logout(bool value) {
    _logout = value;
    notifyListeners();
  }
  String get userId => _userId;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  String _profilePic = "";
  String _profilePicKey ="";


  String get profilePicKey => _profilePicKey;

  set profilePicKey(String value) {
    _profilePicKey = value;
    notifyListeners();
  }

  String get profilePic => _profilePic;

  set profilePic(String value) {
    _profilePic = value;
    notifyListeners();
  }

  bool get female => _female;

  set female(bool value) {
    _female = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
  Future<bool> createNannyAccount(BuildContext context,String group) async {
   print(firstNamesController.text);
   print(lastNamesController.text);
   print(aboutController.text);
   print("email is "+ email);
   print("latitude is  $latitude");
   print("longitude is $longitude");
   print("username is"+username);
    loading = true;

    try {
      String graphQLDocument =
      '''
      mutation create(
            \$username: String!
            \$email: AWSEmail!
            \$type:UserType!
            \$firstName:String!
            \$lastName:String!
            \$profilePicUrl:String!
            \$day:Int!
            \$month:Int!
            \$year:Int!
            \$dateOfBirth:AWSDate!
            \$age:Int!
            \$male:Boolean!
            \$female:Boolean!
            \$address:String!
            \$about:String!
            \$longitude:Float!
            \$latitude:Float!
            \$status:UserAccountStatus!) {
  createUser(user: {
  about: \$about, address: \$address, age: \$age, 
  dateOfBirth: \$dateOfBirth, day: \$day, email: \$email, female: \$female, 
  firstName: \$firstName, lastName: \$lastName, latitude: \$latitude, longitude: \$longitude, male: \$male, month: \$month, 
  profilePicUrl: \$profilePicUrl,status: \$status, type: \$type, username: \$username, year: \$year}) {
    about
    address
    age
    createdOn
    dateOfBirth
    day
    email
    female
    firstName
    id
    lastName
    latitude
    longitude
    male
    month
    profilePicUrl
    status
    type
    username
    year
  }
}
      ''';

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(
            document: graphQLDocument,
            apiName: "BabySitterApi_AMAZON_COGNITO_USER_POOLS",
            variables: {
              "about":"aboutController.text",
              "address":"addressController.text",
              "age":34,
              "dateOfBirth":"2020-10-20",
              "day":3,
              "email":'treyrosius@gmail.com',
              "female":false,
              "firstName":"firstNamesController.text",
              "lastName":"lastNamesController.text",
              "latitude":10.5,
              "longitude":2.5,
              "male":true,
              "month":34,
              "profilePicUrl":"rosius.jpg",
              "status":"VERIFIED",
              "type":'NANNY',
              "username":"roro",
              "year":2022
            },
          ));

      var response = await operation.response;

      var data = response.data;

      print('Mutation result is' + data);
      print('Mutation error: ' + response.errors.toString());


      loading = false;
      return true;

    } catch (ex) {

      print(ex.toString());
      loading = false;
      return false;

    }


  }



  void showInSnackBar(BuildContext context,String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle( fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition().then((value){
      print("longitude" + value.longitude.toString());
      print("latitude" + value.latitude.toString());
      longitude = value.longitude;
      latitude = value.latitude;
      return value;
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose

    firstNamesController.dispose();
    lastNamesController.dispose();
   addressController.dispose();
  aboutController.dispose();
    dateOfBirthController.dispose();


    super.dispose();
  }

  Future<Null> cropImage(String imageFilePath,
      BuildContext context, String targetPath) async {
    loading = true;
    var uuid =  Uuid().v1();

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFilePath,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square]
            : [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Theme.of(context).colorScheme.secondary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      print("cropped file is" + croppedFile.path);



      Map<String, String> metadata = <String, String>{};
      metadata['name'] = "user_$uuid";

      metadata['desc'] = 'A profile picture ';
      S3UploadFileOptions  options = S3UploadFileOptions(accessLevel: StorageAccessLevel.guest, metadata: metadata,);
      try {
      UploadFileResult result  =  await Amplify.Storage.uploadFile(
            key: uuid,
            local: croppedFile,
            options: options
        );
      profilePicKey  = result.key;
      print("the key is "+profilePicKey);
      GetUrlResult resultDownload =
      await Amplify.Storage.getUrl(key: profilePicKey);
      print(resultDownload.url);
      profilePic = resultDownload.url;
      loading = false;

      } on StorageException catch (e) {
        print("error message is" + e.message);
       loading= false;
      }

    }else{
      loading = false;
    }
  }

  Future<bool>signOut() async{
    try {
      Amplify.Auth.signOut();
      return logout = true;
    } on AuthException catch (e) {

      print(e.message);
      return logout  = false;
    }
  }

  Future<String> retrieveEmail() async{
    var res = await Amplify.Auth.fetchUserAttributes();
    res.forEach((element) {
      print("element is"+element.value);
    });
    return res[3].value;
  }
  Future<AuthUser>retrieveCurrentUser() async{
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
    notifyListeners();
  }

  get month => _month;

  set month(value) {
    _month = value;
    notifyListeners();
  }

  get year => _year;

  set year(value) {
    _year = value;
    notifyListeners();
  }
}