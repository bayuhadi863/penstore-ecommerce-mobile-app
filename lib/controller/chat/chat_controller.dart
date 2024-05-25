import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/chat_model.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.put(ChatController());

  final FirebaseFirestore db = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;

  var chats = <ChatModel>[].obs;

  TextEditingController messageController = TextEditingController();

  // fetch realtime chats
  void fetchChats(String roomId) {
    db
        .collection('chats')
        .where('roomId', isEqualTo: roomId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      chats.value =
          snapshot.docs.map((doc) => ChatModel.fromSnapshot(doc)).toList();
    });
  }

  void sendMessage(ChatModel chat) {
    try {
      db.collection('chats').add({
        'roomId': chat.roomId,
        'senderId': user!.uid,
        'senderName': user!.displayName,
        'recieverId': chat.recieverId,
        'recieverName': chat.recieverName,
        'productId': '',
        'message': messageController.text,
        'createdAt': Timestamp.now(),
        'isSeen': false,
      });
      messageController.clear();
    } catch (e) {
      throw 'Cant send message ${e.toString()}';
    }
  }

  // ubah status baca pesan lawan bicara
  Future<void> markMessagesAsSeen(String roomId, String receiverId) async {
    if (user != null) {
      var unreadMessagesSnapshot = await db
          .collection('chats')
          .where('roomId', isEqualTo: roomId)
          .where('receiverId', isEqualTo: receiverId)
          .where('isSeen', isEqualTo: false)
          .get();

      for (var doc in unreadMessagesSnapshot.docs) {
        await db.collection('chats').doc(doc.id).update({'isSeen': true});
      }
    }
  }

  // create linked product message
  void sendProductMessage(ChatModel chat) {
    try {
      db.collection('chats').add({
        'roomId': chat.roomId,
        'senderId': user!.uid,
        'senderName': user!.displayName,
        'recieverId': chat.recieverId,
        'recieverName': chat.recieverName,
        'productId': chat.productId,
        'isSeen': false,
        'message': messageController.text,
        'createdAt': Timestamp.now(),
      });
      messageController.clear();
    } catch (e) {
      throw 'Cant send message ${e.toString()}';
    }
  }
}
