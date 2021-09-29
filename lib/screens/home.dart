import 'package:fetchingapp/counter/counter_bubble.dart';
import 'package:fetchingapp/main.dart';
import 'package:fetchingapp/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            // userProfileCard(context: context, user: user),
            messageCloud(context),
            Expanded(
              child: chatList(context),
            )
          ],
        ),
      ),
    );
  }
}

Widget messageCloud(BuildContext context) {
  return SizedBox(
    width: 60,
    height: 60,
    child: Stack(
      children: [
        const Icon(CupertinoIcons.chat_bubble_text, size: 60),
        Align(
          alignment: Alignment.topRight,
          child: FutureBuilder(
            future: Provider.of<ReadMessageChanges>(context)
                .getAllUnreadMessages(userChats),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('');
              } else {
                if ((snapshot.data as int) == 0) {
                  return Text('');
                } else {
                  return CounterBubble(unreadMessages: (snapshot.data as int));
                }
              }
            },
          ),
        )
      ],
    ),
  );
}

Widget chatList(BuildContext context) {
  return ListView.builder(
    itemCount: userChats.length,
    itemBuilder: (context, index) {
      final chat = userChats[index];
      return ListTile(
        onTap: () => Provider.of<ReadMessageChanges>(context, listen: false)
        .readChatMessages(chat),
        leading: const Icon(Icons.person),
        title: Text('Chat ID: $chat'),
        trailing: FutureBuilder(
          future:
              Provider.of<ReadMessageChanges>(context).getChatUnreadCount(chat),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('');
            } else {
              if ((snapshot.data as int) == 0) {
                return Text('');
              } else {
                return CounterBubble(unreadMessages: (snapshot.data as int));
              }
            }
          },
        ),
      );
    },
  );
}
