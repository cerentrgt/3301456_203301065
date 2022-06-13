import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_notebook/MyBackGround/DreamBackground.dart';
import 'package:memory_notebook/Screens/DreamPage/DreamScreens/DreamList.dart';

import 'package:memory_notebook/service/StatusService.dart';

class DreamAdd extends StatefulWidget {
  const DreamAdd({Key? key}) : super(key: key);

  @override
  State<DreamAdd> createState() => _DreamAddState();
}

class _DreamAddState extends State<DreamAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HAYALLERİNİ EKLE"),
        backgroundColor: Colors.indigo[300],
      ),
      body: DreamsBody(),
    );
  }
}

class DreamsBody extends StatefulWidget {
  @override
  State<DreamsBody> createState() => _DreamsBodyState();
}

class _DreamsBodyState extends State<DreamsBody> {
  var txtDescriptions = TextEditingController();

  StatusService statusService = StatusService();
  final ImagePicker pickerImage = ImagePicker();
  dynamic pickImage;
  PickedFile? profileImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.deepPurpleAccent,
      padding: EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    );
    return DreamBackground(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "HAYAL OLUŞTUR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    color: Colors.indigoAccent),
              ),
              SizedBox(height: size.height * 0.03),
              Center(
                child: imagePlace(),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: size.width * 0.3),
                  InkWell(
                    onTap: () =>
                        _onImageButton(ImageSource.camera, context: context),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.indigoAccent,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  InkWell(
                    onTap: () =>
                        _onImageButton(ImageSource.gallery, context: context),
                    child: Icon(
                      Icons.image,
                      color: Colors.indigoAccent,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [

                    SizedBox(height: size.height * 0.03),
                    buildDescriptionsField(),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: style,
                    child: const Text(
                      "KAYDET",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    onPressed: () {

                      statusService.addStatus(
                          txtDescriptions.text, profileImage!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DreamList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  buildDescriptionsField() {
    return TextField(
      decoration: const InputDecoration(labelText: "HAYALİN NEDİR?"),
      textCapitalization: TextCapitalization.words,
      controller: txtDescriptions,
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
