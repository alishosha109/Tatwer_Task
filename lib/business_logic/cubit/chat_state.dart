part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class NoNewMessages extends ChatState {
  final List<Message> messages;

  NoNewMessages(
    this.messages,
  );
}

class NewMessageAdded extends ChatState {
  final List<Message> messages;

  NewMessageAdded(
    this.messages,
  );
}

class choicesAdded extends ChatState {
  final List<String> choices;

  choicesAdded(
    this.choices,
  );
}
