import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/muser.dart';
import 'package:lolly_flutter/viewmodels/misc/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final vm = LoginViewModel();
  MUser get item => vm.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      "Lolly",
                      style: TextStyle(fontSize: 50),
                    )),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "USERNAME",
                      ),
                      style: TextStyle(fontSize: 30),
                      onSaved: (s) => item.username = s,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "PASSWORD",
                      ),
                      style: TextStyle(fontSize: 30),
                      onSaved: (s) => item.password = s,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState.validate())
                                      return;
                                    _formKey.currentState.save();
                                    Global.userid = await vm.login();
                                    if (Global.userid.isEmpty) {
                                    } else {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          "userid", Global.userid);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(fontSize: 30),
                                  ))),
                        )
                      ],
                    )
                  ]))));
}
