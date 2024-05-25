enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

List demeChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed nisi lacus sed viverra tellus in hac. Diam quis enim lobortis scelerisque fermentum dui. Pulvinar sapien et ligula ullamcorper. Sapien et ligula ullamcorper malesuada. Vitae congue eu consequat ac felis donec. Bibendum arcu vitae elementum curabitur vitae nunc sed. Dictumst quisque sagittis purus sit amet. Dolor magna eget est lorem ipsum dolor sit. Pulvinar sapien et ligula ullamcorper. Vel quam elementum pulvinar etiam non quam. Sed nisi lacus sed viverra tellus in hac habitasse. Felis imperdiet proin fermentum leo vel orci. Elementum pulvinar etiam non quam. Orci porta non pulvinar neque. Risus ultricies tristique nulla aliquet enim tortor. Varius quam quisque id diam. Dictum varius duis at consectetur lorem. Donec adipiscing tristique risus nec feugiat in fermentum posuere. Id porta nibh venenatis cras sed felis eget.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sed nisi lacus sed viverra tellus in hac. Diam quis enim lobortis scelerisque fermentum dui. Pulvinar sapien et ligula ullamcorper. Sapien et ligula ullamcorper malesuada. Vitae congue eu consequat ac felis donec. Bibendum arcu vitae elementum curabitur vitae nunc sed. Dictumst quisque sagittis purus sit amet. Dolor magna eget est lorem ipsum dolor sit. Pulvinar sapien et ligula ullamcorper. Vel quam elementum pulvinar etiam non quam. Sed nisi lacus sed viverra tellus in hac habitasse. Felis imperdiet proin fermentum leo vel orci. Elementum pulvinar etiam non quam. Orci porta non pulvinar neque. Risus ultricies tristique nulla aliquet enim tortor. Varius quam quisque id diam. Dictum varius duis at consectetur lorem. Donec adipiscing tristique risus nec feugiat in fermentum posuere. Id porta nibh venenatis cras sed felis eget.",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: true, 
  ),
  // ChatMessage(
  //   text: "",
  //   messageType: ChatMessageType.audio,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: false,
  // ),
  // ChatMessage(
  //   text: "",
  //   messageType: ChatMessageType.video,
  //   messageStatus: MessageStatus.viewed,
  //   isSender: true,
  // ),
  ChatMessage(
    text: "Error happend",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_sent,
    isSender: true,
  ),
  ChatMessage(
    text: "This looks great man!!",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.viewed,
    isSender: false,
  ),
  ChatMessage(
    text: "Glad you like it",
    messageType: ChatMessageType.text,
    messageStatus: MessageStatus.not_view,
    isSender: true,
  ),
];
