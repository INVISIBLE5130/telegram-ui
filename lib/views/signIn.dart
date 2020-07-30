import 'package:flutter/material.dart';
import 'package:telegram_ui/widgets/widget.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 100),
              child: Transform.rotate(
                  angle: 6,
                  child: Icon(
                      Icons.send,
                      size: 150,
                      color: Colors.blue
                  ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password'
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text('Forgot password?'),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 32, bottom: 16),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Text('Sign In', style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Don`t have account?'),
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Register now', style: TextStyle(
                          decoration: TextDecoration.underline
                      ),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}