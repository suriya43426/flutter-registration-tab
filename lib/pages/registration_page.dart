import 'dart:io';
import 'package:path/path.dart';

// ignore: avoid_web_libraries_in_flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_registation/models/profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  CollectionReference _profilesCollection =
      FirebaseFirestore.instance.collection('profilesCollection');

  FirebaseStorage _storage = FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();
  File _selectedImageFile;

  final _formKey = GlobalKey<FormState>();
  Profile _profile = Profile();

  getImage() async {
    final selectedFile = await _picker.getImage(source: ImageSource.camera);
    print(selectedFile.path);

    setState(() {
      _selectedImageFile = File(selectedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 15),
                ),
                TextFormField(
                  validator: RequiredValidator(errorText: 'กรุณากรอกชื่อ'),
                  onSaved: (String firstName) {
                    _profile.firstName = firstName;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text('LastName', style: TextStyle(fontSize: 15)),
                TextFormField(
                  validator: RequiredValidator(errorText: 'กรุณากรอกนามสกุล'),
                  onSaved: (String lastName) {
                    _profile.lastName = lastName;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Email', style: TextStyle(fontSize: 15)),
                TextFormField(
                  validator: MultiValidator([
                  RequiredValidator(errorText: 'กรุณากรอก Email'),
                    EmailValidator(errorText: 'กรุณากรอก email ที่ถูกต้อง')]
                  ),
                  onSaved: (String email) {
                    _profile.email = email;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Camera', style: TextStyle(fontSize: 15)),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Ink(
                    color: Colors.grey[300],
                    child: InkWell(
                        onTap: () {
                          print('xxx');
                          getImage();
                        },
                        child: _selectedImageFile != null
                            ? Image.file(_selectedImageFile)
                            : Container(
                                height: 150,
                                child: Center(
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () async {
                      print('Regis');
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(
                            '${_profile.firstName} ${_profile.lastName} ${_profile.email}');
                        
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context){
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 10,),
                                    Text('กำลังบันทึกข้อมูล')
                                  ],
                                ),
                              ),
                            );
                          }
                        );

                        await _profilesCollection.add({
                          'first_name': _profile.firstName,
                          'last_name': _profile.lastName,
                          'email': _profile.email
                        });

                        if (_selectedImageFile != null) {
                          String fileName = basename(_selectedImageFile.path);
                          _storage
                              .ref()
                              .child('images')
                              .child('register')
                              .child(fileName)
                              .putFile(_selectedImageFile);
                        }
                        Navigator.pop(context);
                        _formKey.currentState.reset();

                        setState(() {
                          _selectedImageFile=null;
                        });
                      }
                    },
                    child: Text('ลงทะเบียน'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
