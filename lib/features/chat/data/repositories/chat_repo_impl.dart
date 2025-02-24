
import 'package:growmind_tutuor/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:growmind_tutuor/features/chat/data/model/message_model.dart';
import 'package:growmind_tutuor/features/chat/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/domain/repo/chat_repositories.dart';

class ChatRepoImpl implements ChatRepositories {
  final ChatRemoteDatasource chatRemoteDatasource;
  ChatRepoImpl(this.chatRemoteDatasource);

  @override
  Stream<List<Message>> getMessage(String receiverId, String senderId) {
    return chatRemoteDatasource.getMessages(receiverId, senderId);
  }

  @override
  Future<void> sendMessage(Message message) async {
    final messageModel = MessageModel(
        senderId: message.senderId,
        receiverId: message.receiverId,
        message: message.message,
        timeStamp: message.timeStamp);
    await chatRemoteDatasource.sendMessage(messageModel);
  }
}
