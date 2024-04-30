import 'package:flutter/material.dart';
import 'package:pass_mana/auth.dart';
import 'package:pass_mana/models/user.dart';
import 'package:pass_mana/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class RegForm extends StatefulWidget {
  @override
  _Regform createState() => _Regform();
}

class _Regform extends State<RegForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthService _auth = AuthService();

  String? _nameError;
  String? _emailError;
  String? _passError;
  int? err = 0;
  int? perr;

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

  void _regtoauth() async {
    if (_nameController.text.isEmpty) {
      err = 1;
      setState(() {
        _nameError = "Must not be empty!";
      });
    } else {
      _nameError = null;
    }

    if (isPasswordValid(_passController.text)) {
      setState(() {
        _passError = null;
      });
    } else {
      err = 1;
      _passError;
    }

    if (isEmailValid(_emailController.text)) {
      _emailError = null;
    } else {
      err = 1;
      setState(() {
        _emailError = 'Invalid Email!';
      });
    }

    if (err != 1) {
      await _auth.reg(
          _nameController.text, _emailController.text, _passController.text);
      await _auth.signout();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Authenticate()),
      );
    }
    err = 0;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _nameError,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _emailError,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: _passError,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _regtoauth();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
