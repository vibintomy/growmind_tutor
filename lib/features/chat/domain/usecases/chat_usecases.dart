
import 'package:growmind_tutuor/features/chat/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/domain/repo/chat_repositories.dart';

class ChatUsecases {
  final ChatRepositories chatRepositories;
  ChatUsecases(this.chatRepositories);

  Stream<List<Message>> callReceiver(String receiverId,String senderId) {
    return chatRepositories.getMessage(receiverId,senderId);
  }

  Future<void> callSender(Message message) {
    return chatRepositories.sendMessage(message);
  }
}
