import 'package:equatable/equatable.dart';
import 'package:growmind_tutuor/features/chat/domain/entities/chat_entities.dart';


abstract class ChatEvent extends Equatable {
  ChatEvent();
  @override
  List<Object?> get props => [];
}

class LoadMessages extends ChatEvent {
  final String receiverId;
  final String senderId;
  LoadMessages(this.receiverId, this.senderId);

  @override
  List<Object?> get props => [receiverId,senderId];
}

class SendMessages extends ChatEvent {
  final Message message;
  SendMessages(this.message);
  @override
  List<Object?> get props => [message];
}
