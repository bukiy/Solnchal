// import 'package:firebase_chat_example/model/user.dart';
import 'messages_widget.dart';
import 'new_message_widget.dart';
// import 'profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:EAgric/services/database/user_database_helper.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.blue,
    body: SafeArea(
      child: Column(
        children: [
            Container(
            height: 80,
            padding: EdgeInsets.all(16).copyWith(left: 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(color: Colors.white),
                    Expanded(
                      child: Text(
                        "Adviser",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white54,
                            ),
                            child: Icon(Icons.call, size: 25, color: Colors.white),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white54,
                          ),
                          child: Icon(Icons.videocam, size: 25, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 4),
                  ],
                )
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: MessagesWidget(idUser: "aQX1OWFQ0cRWeMhwQSyJ9U0N7xV2"),
            ),
          ),
          NewMessageWidget(idUser: "aQX1OWFQ0cRWeMhwQSyJ9U0N7xV2")
        ],
      ),
    ),
  );
}
