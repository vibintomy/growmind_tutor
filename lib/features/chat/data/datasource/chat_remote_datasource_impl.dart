import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growmind_tutuor/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind_tutuor/features/chat/data/model/conversation_model.dart';
import 'package:growmind_tutuor/features/chat/data/model/message_model.dart';
import 'package:growmind_tutuor/features/chat/data/model/students_info_mode.dart';

class ChatRemotDatasourceimpl implements ChatRemoteDatasource {
  final FirebaseFirestore firestore;
  ChatRemotDatasourceimpl(this.firestore);

  @override
  Stream<List<ConversationModel>> getConversation(String tutorId) {
    return firestore
        .collection('chat')
        .where('participants', arrayContains: tutorId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ConversationModel.fromJson({
          ...data,
          'chatRoomId': doc.id,
        }, tutorId);
      }).toList();
    });
  }

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
  Future<void> sendMessage(
      String tutorId, String studentId, String message) async {
    final timestamp = DateTime.now();
    final messageModel = MessageModel(
        id: '',
        senderId: tutorId,
        receiverId: studentId,
        message: message,
        timeStamp: timestamp );
    final chatRoomId = getChatRoomId(tutorId, studentId);
    await firestore
        .collection('chat')
        .doc(chatRoomId)
        .collection('messages')
        .add(messageModel.toJson());
    await firestore.collection('chat').doc(chatRoomId).set({
      'lastMessage': message,
      'lastMessageTime': timestamp,
      'participants': [tutorId, studentId],
    }, SetOptions(merge: true));
  }

  @override
  Future<StudentProfileModel> getStudentProfile(String studentId) async {
    final studentDoc = await firestore.collection('users').doc(studentId).get();
    return StudentProfileModel.fromJson(studentDoc.data()??{}, studentId);
  }

  String getChatRoomId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    return ids.join('_');
  }
}
