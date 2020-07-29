import 'package:flutter/material.dart';
import 'package:telegram_ui/services/auth.dart';
import 'package:telegram_ui/widgets/widget.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  TextEditingController userNameTextController = new TextEditingController();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();

  signMeUp() {
    if(formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(
          emailTextController.text,
          passwordTextController.text
      ).then((val){
        print("$val");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(
            child: CircularProgressIndicator()
        ),
      ) : Container(
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
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty || val.length < 2 ? 'Please provide a valid username' : null;
                    },
                    controller: userNameTextController,
                    decoration: InputDecoration(
                        hintText: 'Username'
                    ),
                  ),
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
                      ).hasMatch(val) ? null : 'Please provide a valid email';
                    },
                    controller: emailTextController,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (val) {
                      return val.length > 6 ? null : 'Please provide password more than 6 characters';
                    },
                    controller: passwordTextController,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                signMeUp();
              },
              child: Container(
                margin: EdgeInsets.only(top: 32, bottom: 16),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Text('Sign Up', style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Already have account?'),
                  Text('Login now', style: TextStyle(

                      decoration: TextDecoration.underline
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
