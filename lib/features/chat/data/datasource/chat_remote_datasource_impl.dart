import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind_tutuor/features/chat/data/model/message_model.dart';


class ChatRemotDatasourceimpl implements ChatRemoteDatasource {
  final FirebaseFirestore firestore;
  ChatRemotDatasourceimpl(this.firestore);
  @override
  Stream<List<MessageModel>> getMessages(String receiverId, String senderId) {
    final chatRoomId = getChatRoomId(senderId, receiverId);
    return firestore
        .collection('chat')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageModel.fromJson({...doc.data(), 'id': doc.id});
      }).toList();
    });
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final chatRoomId = getChatRoomId(message.senderId, message.receiverId);
    await firestore
        .collection('chat')
        .doc(chatRoomId)
        .collection('messages')
        .add(message.toJson());
    await firestore.collection('chat').doc(chatRoomId).set({
      'lastMessage': message.message,
      'lastMessageTime': message.timeStamp,
      'participants': [message.senderId, message.receiverId],
    }, SetOptions(merge: true));
  }

  String getChatRoomId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    return ids.join('_');
  }
}
