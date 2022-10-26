import 'package:tatwer_task/data/apis/chat_apis.dart';
import 'package:tatwer_task/data/apis/experts_apis.dart';
import 'package:tatwer_task/data/models/chat_model.dart';
import 'package:tatwer_task/data/models/experts_model.dart';

class ExpertsRepo {
  final ExpertsApis expertsapi;
  ExpertsRepo(this.expertsapi);

  Future<List<Expert>> getExperts() async {
    final experts = await expertsapi.getExperts();
    if (experts == []) {
      return [];
    }
    return experts.map((trip) => Expert.fromJson(trip)).toList();
  }

  Future<List<Expert>> getonlineExperts() async {
    final experts = await expertsapi.getonlineExperts();
    if (experts == []) {
      return [];
    }
    return experts.map((trip) => Expert.fromJson(trip)).toList();
  }
}
