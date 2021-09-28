import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ReadMessageChanges extends ChangeNotifier {
  Future<int> getUnreadMessages() async {
    int count = 0;
    List<String> userChats = ['tyLp2LZryd1JI3ceDfnt', '32d5W1IpXqrwTHkKIlWg'];
    await FirebaseFirestore.instance
        .collection('test_chats')
        .where(FieldPath.documentId, whereIn: userChats)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        for (var message in doc.data()['messages']) {
          if (message['read'] == false) {
            count++;
          }
        }
      }
    });
    return count;
  }

  readChatMessages() async {
    List<Map> readMessages = [];
    await FirebaseFirestore.instance
        .collection('test_chats')
        .doc('tyLp2LZryd1JI3ceDfnt')
        .get()
        .then((value) {
      for (var message in value.data()!['messages']) {
        if (message['read'] == false) {
          message['read'] = true;
          readMessages.add(message);
        } else {
          readMessages.add(message);
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('test_chats')
        .doc('tyLp2LZryd1JI3ceDfnt')
        .set({'messages': readMessages});

    notifyListeners();
  }
}
