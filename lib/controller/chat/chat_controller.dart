import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/models/chat_model.dart';

class ChatController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;

  final String roomId;
  var chats = <ChatModel>[].obs;

  // pengisian saat ini
  var chat = ChatModel.empty().obs;

  TextEditingController messageController = TextEditingController();

  ChatController(this.roomId);

  @override
  void onInit() {
    super.onInit();
    chat.value.roomId = roomId;
    fetchChats(roomId);
  }

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
    }, onError: (error) {
      // throw error;
    });
  }

  void sendMessage() {
    try {
      db.collection('chats').add({
        'roomId': chat.value.roomId,
        'senderId': user!.uid,
        'senderName': user!.displayName,
        'recieverId': '',
        'recieverName': '',
        'productId': '',
        'message': messageController.text,
        'createdAt': Timestamp.now(),
        'isSeen': false,
      });
      messageController.clear();
      chat.value = ChatModel.empty();
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
  void sendProductMessage() {
    try {
      db.collection('chats').add({
        'roomId': chat.value.roomId,
        'senderId': user!.uid,
        'senderName': user!.displayName,
        'recieverId': '',
        'recieverName': '',
        'productId': chat.value.productId,
        'isSeen': false,
        'message': '',
        'createdAt': Timestamp.now(),
      });
      messageController.clear();
      chat.value = ChatModel.empty();
    } catch (e) {
      throw 'Cant send message ${e.toString()}';
    }
  }
}
