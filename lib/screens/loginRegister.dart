import 'package:flutter/material.dart';
import 'package:crypto_app/screens/signIn.dart';
import 'package:crypto_app/screens/signUp.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/login.png', height: 350.0),
              SizedBox(height: 20),
              Text(
                'Fast And \n Flexible Trading',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF8F8F8),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Color(0xFFF5C249), // Text color
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), // Button corner radius
                      ),
                    ),
                    child: Text('Login'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Color(0xFFF5C249), // Text color
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), // Button corner radius
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
