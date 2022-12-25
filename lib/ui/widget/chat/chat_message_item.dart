import 'package:flutter/material.dart';
import 'package:moneyger/model/chat_model.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatModel chat;

  const ChatMessageItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Align(
          alignment: (chat.isAnswer) ? Alignment.topLeft : Alignment.topRight,
          child: Container(
            margin: (chat.isAnswer)
                ? const EdgeInsets.only(right: 50)
                : const EdgeInsets.only(left: 50),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (chat.isAnswer) ? Colors.grey.shade200 : Colors.blue[200],
            ),
            child: Text(
              chat.text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
