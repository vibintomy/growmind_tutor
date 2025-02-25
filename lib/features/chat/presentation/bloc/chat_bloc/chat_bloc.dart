import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/entities/chat_entities.dart';
import 'package:growmind_tutuor/features/chat/domain/domain/usecases/get_message_usecase.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_event.dart';
import 'package:growmind_tutuor/features/chat/presentation/bloc/chat_bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUsecases usecases;
  ChatBloc(this.usecases) : super(ChatInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      await emit.forEach(
          usecases.callReceiver(event.receiverId, event.senderId),
          onData: (List<Message> messages) => ChatLoaded(message: messages),
          onError: (_, __) => ChatError());
    });
    on<SendMessages>((event, emit) async {
      try {
        await usecases.callSender(event.message);
      } catch (e) {
        emit(ChatError());
      }
    });
  }
}
