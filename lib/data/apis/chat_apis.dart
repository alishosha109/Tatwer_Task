import 'package:dio/dio.dart';
import 'package:tatwer_task/constants/strings.dart';

class ChatApis {
  late Dio dio;
  ChatApis() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 30 * 1000,
      receiveTimeout: 30 * 1000,
      headers: {
        "authorization": "${acctoken}",
        "Content-Type": "application/json; charset=UTF-8"
      },
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    );
    dio = Dio(options);
  }

  Future<dynamic> generateNextMessage(index, user) async {
    // here is supposed to have api request that gets the  chat paginated from the server but now we will
    // generate some dummy data
    late var message;
    try {
      // Response response = await dio
      //     .get('chat/${id}', queryParameters: {'page': page,});
      // var data = response.data;
      // return data;
      switch (index) {
        case 0:
          {
            message = {"message": "Hi, What is your Firstname?", "from": "0"};
          }
          break;
        case 2:
          {
            message = {
              "message": "Ok, $user What is your Lastname?",
              "from": "0"
            };
          }
          break;
        case 4:
          {
            message = {"message": "Mr $user, What is your title?", "from": "0"};
          }
          break;
        case 6:
          {
            message = {
              "message": "What Categories you will need to expert in?",
              "from": "0"
            };
          }
          break;
      }

      return message;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
