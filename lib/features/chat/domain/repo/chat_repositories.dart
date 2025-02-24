
import 'package:growmind_tutuor/features/chat/domain/entities/chat_entities.dart';

abstract class ChatRepositories {
  Stream<List<Message>> getMessage(String receiverId,String senderId);
  Future<void> sendMessage(Message message);
}
