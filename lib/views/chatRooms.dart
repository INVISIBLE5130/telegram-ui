import 'package:flutter/material.dart';
import 'package:telegram_ui/helper/authenticate.dart';
import 'package:telegram_ui/services/auth.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(child: Text('Edit', style: TextStyle(
          fontSize: 18
        ),)),
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Center(child: Text('Chats')),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate(),
              ));
            },
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}
