import 'package:flutter/material.dart';
import 'package:telegram_ui/helper/helperfunctions.dart';
import 'package:telegram_ui/services/auth.dart';
import 'package:telegram_ui/services/database.dart';
import 'package:telegram_ui/views/chatRooms.dart';
import 'package:telegram_ui/widgets/widget.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController =
  new TextEditingController();

  AuthMethods authService = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "userName": usernameEditingController.text,
            "userEmail": emailEditingController.text
          };

          databaseMethods.addUserInfo(userDataMap);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
          HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Telegram'),
        ),
      ),
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
                      return val.isEmpty || val.length < 2
                          ? 'Please provide a valid username'
                          : null;
                    },
                    controller: usernameEditingController,
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
                    controller: emailEditingController,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (val) {
                      return val.length > 6
                          ? null
                          : 'Please provide password more than 6 characters';
                    },
                    controller: passwordEditingController,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                singUp();
              },
              child: Container(
                margin: EdgeInsets.only(top: 32, bottom: 16),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                  GestureDetector(
                    onTap: () {
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('Login now', style: TextStyle(
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
