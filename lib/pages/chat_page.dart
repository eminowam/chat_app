import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mozz/components/chat_bubble.dart';
import 'package:mozz/components/custom_text_field.dart';
import 'package:mozz/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageEditingController =
      TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageEditingController.text.isNotEmpty) {
      print("if");
      await _chatService.sendMessages(
          widget.receiverUserId, _messageEditingController.text);
      _messageEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.receiverUserEmail,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 17,
              color: Colors.black,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          children: [
            const Divider(
              thickness: 0.5,
            ),
            Expanded(child: _buildMessageList()),
            _buildMessageInput()
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    String? currentUserId = _firebaseAuth.currentUser?.uid;

    if (currentUserId == null) {
      return SizedBox(); // Если идентификатор текущего пользователя не определен, просто возвращаем пустой виджет
    }

    bool isCurrentUser = data['senderIf'] == currentUserId;

    var mainAxisAlignment = isCurrentUser
        ? MainAxisAlignment.end
        : MainAxisAlignment.start;
    var bubbleColor = isCurrentUser ? Colors.green : Colors.grey[300];
    var textColor = isCurrentUser ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          isCurrentUser ? SizedBox() : _buildAvatar(), // Отображение аватара только для сообщений других пользователей
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   data['senderEmail'],
                  //   style: TextStyle(
                  //     color: Colors.grey[600],
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 5.0),
                  Text(
                    data['message'],
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
          isCurrentUser ? _buildAvatar() : SizedBox(), // Отображение аватара только для сообщений текущего пользователя
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16.0,
      // Здесь можно добавить логику для отображения аватара пользователя
      // Например, если у вас есть ссылка на аватар пользователя в Firestore, вы можете загрузить его сюда.
      // Или вы можете использовать иконку по умолчанию.
      backgroundColor: Colors.grey,
    );
  }




  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            controller: _messageEditingController,
            obscureText: false,
            title: 'Enter message',
          )),
          IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
