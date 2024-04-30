import 'package:flutter/material.dart';

void main() {
  runApp(ForgotPasswordApp());
}

class ForgotPasswordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  String _selectedQuestion = 'What is your favorite color?';
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: _selectedQuestion,
              onChanged: (newValue) {
                _selectedQuestion = newValue.toString();
              },
              items: [
                DropdownMenuItem(
                  value: 'What is your favorite color?',
                  child: Text('What is your favorite color?'),
                ),
                DropdownMenuItem(
                  value: 'What is your pet\'s name?',
                  child: Text('What is your pet\'s name?'),
                ),
                DropdownMenuItem(
                  value: 'What is your mother\'s maiden name?',
                  child: Text('What is your mother\'s maiden name?'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: 'Answer',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement your forgot password logic here
                String email = _emailController.text;
                String answer = _answerController.text;
                if (email.isNotEmpty && answer.isNotEmpty) {
                  // Validate the security question answer and send password reset instructions to the provided email
                  // This is where you'd typically call your API or perform your authentication logic
                  print(
                      'Password reset instructions sent to $email with answer: $answer');
                } else {
                  // Handle empty fields
                  print('Email or answer field is empty');
                }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
