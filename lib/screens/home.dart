import 'package:fetchingapp/counter/counter_bubble.dart';
import 'package:fetchingapp/provider.dart';
import 'package:fetchingapp/screens/chat_screen.dart';
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
            SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                children: [
                  const Icon(CupertinoIcons.chat_bubble_text, size: 60),
                  Align(
                    alignment: Alignment.topRight,
                    child: FutureBuilder(
                      future: Provider.of<ReadMessageChanges>(context)
                          .getAllUnreadMessages(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('');
                        } else {
                          print('snapshot data: ${snapshot.data}');
                          return CounterBubble(
                              unreadMessages: (snapshot.data as int));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Card(
              elevation: 8,
              child: ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatScreen(
                          chatId: 'tyLp2LZryd1JI3ceDfnt',
                        ))),
                leading: const Icon(Icons.person),
                title: const Text('Read Chat'),
                trailing: CounterBubble(
                  unreadMessages: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
