import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  String roomId;
  String? message;
  String senderId;
  String senderName;
  String recieverId;
  String recieverName;
  bool isSeen;
  String? productId;
  String? productImg;
  String? productName;
  String? productPrice;
  DateTime? createdAt;

  ChatModel(
      {required this.id,
      required this.roomId,
      this.message,
      required this.senderId,
      required this.senderName,
      required this.recieverId,
      required this.recieverName,
      required this.isSeen,
      this.productId,
      this.productImg,
      this.productName,
      this.productPrice,
      this.createdAt});

  static ChatModel empty() => ChatModel(
      id: "",
      roomId: "",
      message: "",
      senderId: "",
      senderName: "",
      recieverId: "",
      recieverName: "",
      productId: "",
      productImg: "",
      productName: "",
      productPrice: "",
      isSeen: false,
      createdAt: null);

  Map<String, dynamic> toJson(createdAt) {
    return {
      "id": id,
      "roomId": roomId,
      "message": message,
      "senderId": senderId,
      "senderName": senderName,
      "recieverId": recieverId,
      "recieverName": recieverName,
      "productId": productId,
      "productImg": productImg,
      "productName": productName,
      "productPrice": productPrice,
      "isSeen": isSeen,
      "createdAt": createdAt
    };
  }

  factory ChatModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ChatModel(
        id: snapshot.id,
        roomId: data['roomId'] ?? "",
        message: data['message'] ?? "",
        senderId: data['senderId'] ?? "",
        senderName: data['senderName'] ?? "",
        recieverId: data['recieverId'] ?? "",
        productId: data['productId'] ?? "",
        recieverName: data['recieverName'] ?? "",
        productImg: data['productImg'] ?? "",
        productName: data['productName'] ?? "",
        productPrice: data['productPrice'] ?? "",
        isSeen: data['isSeen'] ?? false,
        createdAt: data['createdAt']?.toDate());
  }
}
