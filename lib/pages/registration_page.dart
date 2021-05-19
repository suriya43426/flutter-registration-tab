import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
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
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                Text('LastName', style: TextStyle(fontSize: 15)),
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                Text('Email', style: TextStyle(fontSize: 15)),
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                Text('Camera', style: TextStyle(fontSize: 15)),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Ink(
                    color: Colors.grey[300],
                    child: InkWell(
                      onTap: (){
                        print('xxx');
                      },
                      child: Container(
                        height: 200,
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
                    onPressed: () {
                      print('Regis');
                    },
                    child: Text('SendRegister'),
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
