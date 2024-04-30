import 'package:flutter/material.dart';
import 'package:pass_mana/database.dart';
import 'package:pass_mana/models/user.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final String pasttitle;
  final String pastemail;
  final String pastpass;
  final String pastkey;
  final String docuid;
  const EditProfile(
      {super.key,
      required this.pasttitle,
      required this.pastemail,
      required this.pastpass,
      required this.pastkey,
      required this.docuid});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController keyController = TextEditingController();

  String? titleErrorText;
  String? emailErrorText;
  String? passwordErrorText;

  String? _nameError;
  String? _emailError;
  String? _passError;
  String? _keyError;

  int? perr;

  bool iskeyValid(String password) {
    if (password.isEmpty || password.length == 7) {
      _keyError = "Must be  8 characters.";
      return false;
    }
    return true;
  }

  bool isPasswordValid(String password) {
    if (password.isEmpty || password.length < 8) {
      _passError = "Must be atleast 8 characters.";
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      _passError = "Must contain at least one uppercase letter.";
      return false;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      _passError = "Must contain at least one lowercase letter.";
      return false;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      _passError = "Must contain at least one digit.";
      return false;
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _passError = "Must contain at least one special character.";
      return false;
    }
    return true;
  }

  bool isEmailValid(String email) {
    if (email == null || !email.contains('@')) {
      return false;
    }

    List<String> parts = email.split('@');
    if (parts.length != 2) {
      return false;
    }

    if (parts[0].isEmpty) {
      return false;
    }

    if (!parts[1].contains('.')) {
      return false;
    }

    return true;
  }

  int validateInputs() {
    int? err = 0;
    if (titleController.text.isEmpty) {
      err = 1;
      setState(() {
        _nameError = "Must not be empty!";
      });
    } else {
      _nameError = null;
    }

    if (isPasswordValid(passwordController.text)) {
      setState(() {
        _passError = null;
      });
    } else {
      err = 1;
      _passError;
    }

    if (isEmailValid(emailController.text)) {
      _emailError = null;
    } else {
      err = 1;
      setState(() {
        _emailError = 'Invalid Email!';
      });
    }

    if (iskeyValid(keyController.text)) {
      _keyError = null;
    } else {
      err = 1;
      setState(() {
        _keyError;
      });
    }

    return err;
  }

  @override
  Widget build(BuildContext context) {
    final CUser? user = Provider.of<CUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: titleController,
              // initialValue: widget.pasttitle,
              decoration: InputDecoration(
                labelText: 'Title',
                errorText: _nameError,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              // initialValue: widget.pastemail,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailError,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              // initialValue: widget.pastpass,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passError,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: keyController,
              // initialValue: widget.pastkey,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Key',
                errorText: _keyError,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (validateInputs() == 0) {
                  await Dbservice(uid: user!.uid).EditProfile(
                      titleController.text,
                      emailController.text,
                      passwordController.text,
                      keyController.text,
                      widget.docuid);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
