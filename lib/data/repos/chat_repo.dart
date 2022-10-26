import 'package:tatwer_task/data/apis/chat_apis.dart';
import 'package:tatwer_task/data/models/chat_model.dart';

class ChatRepo {
  final ChatApis chatapis;
  ChatRepo(this.chatapis);

  Future<dynamic> generateNextMessage(index, user) async {
    final message = await chatapis.generateNextMessage(index, user);
    if (message == []) {
      return [];
    }
    return Message.fromJson(message);
  }
}
