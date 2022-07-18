// ignore_for_file: file_names, prefer_const_constructors, non_constant_identifier_names, avoid_print
import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _firstName_controller = TextEditingController();
  final _lastName_controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? imageinGallery;

  Future pickInGallery() async {
    try {
      final imageinGallery =
          await _picker.pickImage(source: ImageSource.gallery);
      if (imageinGallery == null) return;
      final imageTemp = File(imageinGallery.path);
      setState(() {
        this.imageinGallery = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Fail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: HexColor('#5AA6FF'),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Stack(
                            children: [
                              profileImg(),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: pickImage(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          textField(_firstName_controller, 'First Name',
                              'Can\'t empty'),
                          const SizedBox(height: 30),
                          textField(_lastName_controller, 'Last Name',
                              'Can\'t empty'),
                          const SizedBox(height: 100),
                          saveBtn('Save', () {
                            if (_formKey.currentState!.validate()) {
                              updateDisplayName(
                                _firstName_controller.text,
                                _lastName_controller.text,
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget profileImg() {
    final image = AssetImage('assets/profile.jpeg');
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: imageinGallery == null
            ? Ink.image(
                image: image,
                fit: BoxFit.contain,
                width: 100,
                height: 100,
                child: InkWell(
                  onTap: () => pickInGallery(),
                ),
              )
            : Image.file(
                imageinGallery!,
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
      ),
    );
  }

  Widget pickImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => pickInGallery(),
          child: Container(
            padding: EdgeInsets.all(4),
            color: HexColor('#000000').withOpacity(0.6),
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white.withOpacity(0.5),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget saveBtn(String btnText, btnMethode) {
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        color: HexColor('#141A1E'),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: HexColor('#000000').withOpacity(0.40),
            offset: const Offset(0, 6),
            blurRadius: 8,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: btnMethode,
          child: Center(
            child: Text(
              btnText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      TextEditingController _controller, String label, String errorText) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return errorText;
        } else {
          return null;
        }
      },
      controller: _controller,
      decoration: InputDecoration(
        fillColor: HexColor('#1F2431').withOpacity(0.70),
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          color: HexColor('#B4B4B4'),
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#1F2431'),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: HexColor('#1F2431').withOpacity(0.2),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.6),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 2,
            color: Colors.red.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Future<void> updateDisplayName(String fname, String lname) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName('$fname $lname');
    }
    Navigator.pop(context);
  }

  Future<void> updatePhotoUrl(photoURL) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePhotoURL(photoURL);
    }
  }
}
