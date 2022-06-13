import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_notebook/Screens/HomePage/MyHomePage.dart';
import 'package:memory_notebook/Screens/SettingsPage/SettingsPage.dart';
import 'package:memory_notebook/service/AuthService.dart';

import '../../../service/StatusService.dart';
import '../../HomePage/HomeScreens/HomePage.dart';

class UserBody extends StatefulWidget {
  const UserBody({Key? key}) : super(key: key);

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  AuthService authService = AuthService();
  var userEmail = FirebaseAuth.instance.currentUser!.email ?? "";
  var userName = FirebaseAuth.instance.currentUser!.displayName ?? "";
  var userProfil = FirebaseAuth.instance.currentUser!.photoURL ??
      "https://dbdzm869oupei.cloudfront.net/img/sticker/preview/20084.png";

  StatusService statusService = StatusService();
  final ImagePicker pickerImage = ImagePicker();
  dynamic pickImage;
  PickedFile? profileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD1C4E9),
              Color(0xFFB39DDB),
              Color(0xFF9575CD),
              Color(0xFF7E57C2),
            ]),
      ),
      child: Column(
        children: [
          userImageButton(),
          const SizedBox(height: 10),
          userNameButton(),
          userMailButton(),
          goHome(),
          goSettings(),
          goOut(),
        ],
      ),
    );
  }

  Widget userImageButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        userProfil,
                      ),
                    ),
                    Positioned(
                      right: -12,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: FlatButton(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side:
                                const BorderSide(color: Colors.grey, width: 5),
                          ),
                          onPressed: () {
                            showAlertDialog();
                          },
                          child: const Icon(Icons.camera),
                          color: const Color(0xFFF5F6F9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(

            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      _onImageButton(ImageSource.camera, context: context);
                      Navigator.pop(context, true);
                    },
                    child: Icon(
                      Icons.camera_alt,
                      size: 45,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  InkWell(
                    onTap: () {
                      _onImageButton(ImageSource.gallery, context: context);
                      Navigator.pop(context, true);
                    },
                    child: Icon(
                      Icons.image,
                      size: 45,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget userNameButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              fixedSize: Size(320, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    userName,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget userMailButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              fixedSize: Size(320, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {},
            child: Row(
              children: [
                Icon(Icons.mail_outline),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    userEmail,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget goHome() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              fixedSize: Size(320, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "AnaSayfa'ya Dön",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget goOut() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              fixedSize: Size(320, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              authService.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Çıkış Yap..!",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget goSettings() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              fixedSize: Size(320, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            child: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Ayarlar",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imagePlace() {
    double height = MediaQuery.of(context).size.height;
    if (profileImage != null) {
      return CircleAvatar(
        backgroundImage: FileImage(
          File(profileImage!.path),
        ),
        radius: height * 0.08,
      );
    } else {
      if (pickImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage(
            pickImage,
          ),
          radius: height * 0.08,
        );
      } else {
        return CircleAvatar(
          backgroundImage: const AssetImage(
            "assets/images/images_6.jpg",
          ),
          radius: height * 0.08,
        );
      }
    }
  }

  void _onImageButton(ImageSource source, {BuildContext? context}) async {
    try {
      final pickedFile = await pickerImage.getImage(source: source);
      setState(() {
        profileImage = pickedFile;
        if (profileImage != null) {}
      });
    } catch (e) {
      setState(() {
        pickImage = e;
        print("Hatamiz :" + pickImage);
      });
    }
  }
}
