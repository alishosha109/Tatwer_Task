import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tatwer_task/constants/strings.dart';
import 'package:tatwer_task/data/models/chat_model.dart';
import 'package:tatwer_task/data/repos/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatrepo;
  List<Message> messages = [];

  ChatCubit(this.chatrepo) : super(ChatInitial());

  List<Message> generateNextMessage(index, {user = "user"}) {
    chatrepo.generateNextMessage(index, user).then((message) {
      if (message == []) {
        emit(NoNewMessages(message));
      } else {
        emit(NewMessageAdded([message]));
      }
      this.messages = [message];
    });
    return messages;
  }

  addmyMessage(text) {
    var msg = {"message": text, "from": mainUserID};
    var message = Message.fromJson(msg);
    emit(NewMessageAdded([message]));
  }

  get_choices() {
    List<String> choices = [
      "Security",
      "Supply Chain",
      "Information Technology",
      "Human Resource",
      "Business Research"
    ];
    emit(choicesAdded(choices));
  }
}
