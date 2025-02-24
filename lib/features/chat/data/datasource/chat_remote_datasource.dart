

import 'package:growmind_tutuor/features/chat/data/model/message_model.dart';

abstract class ChatRemoteDatasource {
  Stream<List<MessageModel>> getMessages(String receiverId,String senderId);
  Future<void> sendMessage(MessageModel message);
}
