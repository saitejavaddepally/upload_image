import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:task/show_details.dart';
import 'package:task/user_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/show': (context) => ShowDetails(),
      },
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<UserDetailsModel> sendPostData(String imgUrl) async {
  final Uri url = Uri.parse(
      "https://backend-test-zypher.herokuapp.com/uploadImageforMeasurement");

  final response = await http.post(url, body: {"imageURL": imgUrl});
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userDetailsModelFromJson(responseString);
  } else
    return null;
}

class _MyHomePageState extends State<MyHomePage> {
  String imageUrl =
      "https://raw.githubusercontent.com/farazBhatti/Human-Body-Measurements-using-Computer-Vision/master/sample_data/input/saif1.jpeg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              uploadImage(imageUrl);
              UserDetailsModel info = await sendPostData(imageUrl);
              Navigator.pushNamed(context, '/show', arguments: {
                "measurementId": info.d.measurementId,
                "neck": info.d.neck,
                "height": info.d.height,
                "weight": info.d.weight,
                "belly": info.d.belly,
                "chest": info.d.chest,
                "wrist": info.d.wrist,
                "armLength": info.d.armLength,
                "thigh": info.d.thigh,
                "shoulder": info.d.shoulder,
                "hips": info.d.hips,
                "ankle": info.d.ankle
              });
            },
            child: Text("Upload Image"),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15))),
      ),
    );
  }
}

uploadImage(String imageUrl) async {
  File file;
  var rng = new Random();
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  print("some $tempPath");
  file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.jpeg');
  http.Response response = await http.get(Uri.parse(imageUrl));
  await file.writeAsBytes(response.bodyBytes);

  if (file == null) return null;

  try {
    final ref = FirebaseStorage.instance.ref("/images/imageName");
    return ref.putFile(file);
  } catch (e) {
    print("Not uploaded");
  }
}
