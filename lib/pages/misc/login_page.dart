import 'package:flutter/material.dart';
import 'package:lolly_flutter/models/misc/mcommon.dart';
import 'package:lolly_flutter/models/misc/muser.dart';
import 'package:lolly_flutter/viewmodels/misc/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final vm = LoginViewModel();
  MUser get item => vm.item;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                      "Lolly",
                      style: TextStyle(fontSize: 50),
                    )),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "USERNAME",
                      ),
                      style: const TextStyle(fontSize: 30),
                      onSaved: (s) => item.username = s ?? "",
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "PASSWORD",
                      ),
                      style: const TextStyle(fontSize: 30),
                      onSaved: (s) => item.password = s ?? "",
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate())
                                      return;
                                    _formKey.currentState!.save();
                                    Global.userid = await vm.login();
                                    if (Global.userid.isEmpty) {
                                      if (!context.mounted) return;
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const SimpleDialog(
                                                title: Text("Login"),
                                                children: [
                                                  SimpleDialogOption(
                                                    child: Text(
                                                        "Wrong username or password!"),
                                                  )
                                                ],
                                              ));
                                    } else {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          "userid", Global.userid);
                                      if (!context.mounted) return;
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 30),
                                  ))),
                        )
                      ],
                    )
                  ]))));
}
