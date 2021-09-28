import 'package:fetchingapp/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.chatId, Key? key}) : super(key: key);
  final String chatId;

  @override
  Widget build(BuildContext context) {
    Provider.of<ReadMessageChanges>(context, listen: false)
        .readChatMessages(chatId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: const Center(
        child: Text(
          'Now go back and check bubbles',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
