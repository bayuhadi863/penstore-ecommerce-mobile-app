import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChatModel {
  final String id;
  List<String> userId;
  String? lastMessage;
  String senderName;
  bool hasUnreadMessages;

  RoomChatModel(
      {required this.id,
      required this.userId,
      this.lastMessage,
      required this.senderName,
      required this.hasUnreadMessages});

  static RoomChatModel empty() => RoomChatModel(
      id: '',
      userId: [],
      lastMessage: '',
      hasUnreadMessages: false,
      senderName: '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'senderName': senderName,
      'lastMessage': lastMessage,
      'hasUnreadMessages': hasUnreadMessages,
    };
  }

  factory RoomChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return RoomChatModel(
      id: snapshot.id,
      userId:
          data['userId'] is Iterable ? List<String>.from(data['userId']) : [],
      lastMessage: data['lastMessage'] ?? '',
      hasUnreadMessages: data['hasUnreadMessages'] ?? false,
      senderName: data['senderName'] ?? '',
    );
  }
}
