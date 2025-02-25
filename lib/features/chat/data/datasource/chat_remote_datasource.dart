import 'package:growmind_tutuor/features/chat/data/model/conversation_model.dart';
import 'package:growmind_tutuor/features/chat/data/model/message_model.dart';
import 'package:growmind_tutuor/features/chat/data/model/students_info_mode.dart';


abstract class ChatRemoteDatasource {
  Stream<List<ConversationModel>> getConversation(String tutorId);
  Stream<List<MessageModel>> getMessages(String receiverId, String senderId);
  Future<void> sendMessage(String tutorId,String studentId,String message);
  Future<StudentProfileModel> getStudentProfile(String studentId);
}
