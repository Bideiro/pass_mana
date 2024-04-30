import 'package:flutter/material.dart';
import 'package:pass_mana/auth.dart';
import 'package:pass_mana/models/user.dart';
import 'package:pass_mana/screens/forgot.dart';
import 'package:pass_mana/screens/reg.dart';
import 'package:provider/provider.dart';

class LoginApp extends StatefulWidget {
  @override
  _LoginApp createState() => _LoginApp();
}

class _LoginApp extends State<LoginApp> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  void _validateLogin(String emailController, String passwordController) async {
    bool err = false;
    // Simulate validation logic here
    if (await _auth.signIn(emailController, passwordController)) {
    } else {
      err = true;
    }

    setState(() {
      if (_emailController.text.isEmpty) {
        _emailError = "Cannot be empty";
      } else if (err == true) {
        _emailError = "Email is wrong.";
      } else {
        _emailError = null;
      }
      if (_passwordController.text.isEmpty) {
        _passwordError = "Cannot be empty";
      } else if (err == true) {
        _passwordError = "Password is wrong.";
      } else {
        _passwordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
          title: 'Login Form',
          theme: ThemeData(
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Text('Welcome to SecureKey!'),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.0),
                      Image.asset(
                        'assets/login_logo.png',
                        height: 150,
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'SecureKey',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType
                            .emailAddress,
                        decoration: InputDecoration(
                          labelText:
                              'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: _emailError,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorText: _passwordError,
                        ),
                      ),
                      SizedBox(height: 10.0), 
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Forgot1()),
                      );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0), // Add some spacing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _validateLogin(_emailController.text,
                                  _passwordController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegForm()),
                              );
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
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
