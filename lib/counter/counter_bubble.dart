import 'package:flutter/material.dart';

class CounterBubble extends StatelessWidget {
  const CounterBubble({required this.unreadMessages, Key? key})
      : super(key: key);
  final int unreadMessages;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 30,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              unreadMessages.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.white),
            )));
  }
}
