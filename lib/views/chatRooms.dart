import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:telegram_ui/helper/authenticate.dart';
import 'package:telegram_ui/services/auth.dart';
import 'package:telegram_ui/services/database.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      await databaseMethods.searchByName(searchEditingController.text)
          .then((snapshot){
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList(){
    return haveUserSearched ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchResultSnapshot.documents.length,
        itemBuilder: (context, index){
          return userTile(
            searchResultSnapshot.documents[index].data["userName"],
            searchResultSnapshot.documents[index].data["userEmail"],
          );
        }) : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
//  sendMessage(String userName){
//    List<String> users = [Constants.myName,userName];
//
//    String chatRoomId = getChatRoomId(Constants.myName,userName);
//
//    Map<String, dynamic> chatRoom = {
//      "users": users,
//      "chatRoomId" : chatRoomId,
//    };
//
//    databaseMethods.addChatRoom(chatRoom, chatRoomId);
//
//    Navigator.push(context, MaterialPageRoute(
//        builder: (context) => Chat(
//          chatRoomId: chatRoomId,
//        )
//    ));
//  }

  Widget userTile(String userName,String userEmail){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
//            onTap: (){
//              sendMessage(userName);
//            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Text("Message",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          )
        ],
      ),
    );
  }


  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            authMethods.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Authenticate(),
            ));
          },
          child: Center(
              child: Icon(Icons.arrow_back_ios, color: Colors.blue)),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Center(child: Text('Chats', style: TextStyle(
            color: Colors.black
          ),)),
        ),
        actions: <Widget>[
          GestureDetector(
//            onTap: () {
//              authMethods.signOut();
//              Navigator.pushReplacement(context, MaterialPageRoute(
//                builder: (context) => Authenticate(),
//              ));
//            },
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.edit, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Theme(
            data: Theme.of(context).copyWith(splashColor: Colors.transparent),
            child: TextField(
              autofocus: false,
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 13.0),
                prefixIcon: GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Icon(Icons.search)
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.05),
                hintText: 'Search for messages or users',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
