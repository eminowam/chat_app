import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff3CED78),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style:const TextStyle(fontSize: 14,color: Colors.black),
      ),
    );
  }
}


class SenderMessage extends StatelessWidget {
  final String message;

  const SenderMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff2B333E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style:const TextStyle(fontSize: 14,color: Colors.black),
      ),
    );
  }
}
