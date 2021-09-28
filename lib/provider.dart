import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ReadMessageChanges extends ChangeNotifier {
  listenOnChatChanges(List<String> userChats) {
    FirebaseFirestore.instance
        .collection('test_chats')
        .where(FieldPath.documentId, whereIn: userChats)
        .snapshots()
        .listen((event) {
      notifyListeners();
    });
  }

  Future<int> getAllUnreadMessages(List<String> userChats) async {
    int count = 0;
    // only looking for chats of particular user
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

  Future<int> getChatUnreadCount(String chatId) async {
    int count = 0;
    await FirebaseFirestore.instance
        .collection('test_chats')
        .doc(chatId)
        .get()
        .then((value) {
      for (var message in value.data()!['messages']) {
        if (message['read'] == false) {
          count++;
        }
      }
    });
    return count;
  }

  readChatMessages(String chatId) async {
    List<Map> readMessages = [];
    await FirebaseFirestore.instance
        .collection('test_chats')
        .doc(chatId)
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
        .doc(chatId)
        .set({'messages': readMessages});
  }
}
