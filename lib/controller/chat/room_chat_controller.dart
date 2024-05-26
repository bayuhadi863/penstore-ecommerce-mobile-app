import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penstore/models/roomChat_model.dart';

class ChatRoomController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  var chatRooms = <RoomChatModel>[].obs;
  var isLoading = false.obs;
  var choosedRoomId = ''.obs;
  var recieverId = ''.obs;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchChatRooms();
  }

  // fetch chat rooms realtime
  void fetchChatRooms() {
    isLoading.value = true;
    if (user != null) {
      db
          .collection('chatRooms')
          .where('userId', arrayContains: user!.uid)
          .orderBy('updatedAt', descending: true)
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

          // ambil nama sender
          room.senderName = await fetchSenderName(room.id);
        }

        chatRooms.value = rooms;
      });
      isLoading.value = false;
    }
  }

  // fetch sender Name
  Future<String> fetchSenderName(String roomId) async {
    try {
      var roomSnapshot = await db.collection('chatRooms').doc(roomId).get();

      // ambil user id yang bukan saya
      if (roomSnapshot.exists) {
        var roomData = roomSnapshot.data() as Map<String, dynamic>;
        var userIds = roomData['userId'] as List<dynamic>;
        var otherUserId = userIds.firstWhere((id) => id != user!.uid);

        var userSnapshot = await db.collection('users').doc(otherUserId).get();

        if (userSnapshot.exists) {
          var userData = userSnapshot.data() as Map<String, dynamic>;
          recieverId.value = otherUserId ?? '';
          return userData['name'] ?? 'Unknown';
        }
      }
    } catch (e) {
      print('Error fetching sender name: $e');
    }
    return 'Unknown';
  }

  // ambil pesan terakhir
  Future<String> fetchLastMessage(String roomId) async {
    try {
      var lastMessageSnapshot = await db
          .collection('chats')
          .where('roomId', isEqualTo: roomId)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (lastMessageSnapshot.docs.isNotEmpty) {
        return lastMessageSnapshot.docs.first['message'];
      }
    } catch (e) {
      print('Error fetching last message: $e');
    }
    return '';
  }

  // cek jika punya pesan baru
  Future<bool> hasUnreadMessages(String roomId) async {
    // cek apakah ada chat yang isSeen = false
    var unreadMessagesSnapshot = await db
        .collection('chats')
        .where('roomId', isEqualTo: roomId)
        .where('isSeen', isEqualTo: false)
        .get();

    // Langkah 2: Filter dokumen yang tidak memiliki senderId sama dengan user.uid
    var unreadMessages = unreadMessagesSnapshot.docs.where((doc) {
      var data = doc.data();
      return data['senderId'] != user!.uid;
    }).toList();

    return unreadMessages.isNotEmpty;
  }

  // buat jika belum ada chat room
  Future<void> createChatRoom(String receiverId) async {
    try {
      List<String> users = [user!.uid, receiverId];

      // cek jika ada
      var existingChatRoomSnapshot = await db
          .collection('chatRooms')
          .where('userId', arrayContainsAny: users)
          .get();

      bool chatRoomExists = existingChatRoomSnapshot.docs.any((doc) {
        var userIds = List<String>.from(doc['userId']);
        return userIds.contains(user!.uid) && userIds.contains(receiverId);
      });

      if (!chatRoomExists) {
        // buat jika belum ada
        await db.collection('chatRooms').add({
          'userId': users,
          'lastMessage': '',
          'hasUnreadMessages': false,
          'updateddAt': Timestamp.now(),
        });
        print('Chat room created successfully');
      } else {
        print('Chat room already exists');
      }
    } catch (e) {
      print('Cant create chat room ${e.toString()}');
    }
  }

  // temukan chat room
  Future<RoomChatModel> findChatRoom(String receiverId) async {
    try {
      var querySnapshot = await db
          .collection('chatRooms')
          .where('userId', arrayContains: user!.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        var userIds = List<String>.from(doc['userId']);
        if (userIds.contains(receiverId)) {
          return RoomChatModel.fromSnapshot(doc);
        }
      }
    } catch (e) {
      print('Error finding chat room: $e');
    }
    return RoomChatModel.empty();
  }

  Future<void> updatedAt(String roomId) async {
    try {
      await db.collection('chatRooms').doc(roomId).update({
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      print('Error updating chat room: $e');
    }
  }
}
