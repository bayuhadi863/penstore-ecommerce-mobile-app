import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penstore/models/roomChat_model.dart';

class ChatRoomController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  var chatRooms = <RoomChatModel>[].obs;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchChatRooms();
  }

  // fetch chat rooms realtime
  void fetchChatRooms() {
    if (user != null) {
      db
          .collection('chatRooms')
          .where('userId', arrayContains: user!.uid)
          .snapshots()
          .listen((snapshot) async {
        var rooms = snapshot.docs
            .map((doc) => RoomChatModel.fromSnapshot(doc))
            .toList();
        for (var room in rooms) {
          // ambil last message
          room.lastMessage = await fetchLastMessage(room.id);
          // cek jika ada pesan baru
          room.hasUnreadMessages = await hasUnreadMessages(room.id);
        }

        chatRooms.value = rooms;
      });
    }
  }

  // ambil pesan terakhir
  Future<String> fetchLastMessage(String roomId) async {
    var lastMessageSnapshot = await db
        .collection('chats')
        .where('roomId', isEqualTo: roomId)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (lastMessageSnapshot.docs.isNotEmpty) {
      return lastMessageSnapshot.docs.first['message'];
    }
    return '';
  }

  // cek jika punya pesan baru
  Future<bool> hasUnreadMessages(String roomId) async {
    var unreadMessagesSnapshot = await db
        .collection('chats')
        .where('roomId', isEqualTo: roomId)
        .where('receiver', isEqualTo: user!.uid)
        .where('isSeen', isEqualTo: false)
        .get();

    return unreadMessagesSnapshot.docs.isNotEmpty;
  }

  void createChatRoom(String senderId, String receiverId) {
    try {
      List<String> users = [senderId, receiverId];

      db.collection('chatRooms').add({
        'userId': users,
        'lastMessage': '',
        'hasUnredMessage': false,
      });
    } catch (e) {
      throw 'Cant create chat room ${e.toString()}';
    }
  }
}
