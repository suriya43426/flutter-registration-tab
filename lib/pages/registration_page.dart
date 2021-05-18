import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
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
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('SendRegister'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
