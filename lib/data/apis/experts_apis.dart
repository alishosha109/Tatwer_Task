import 'package:dio/dio.dart';
import 'package:tatwer_task/constants/strings.dart';

class ExpertsApis {
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

  Future<List<dynamic>> getExperts() async {
    // here is supposed to have api request that gets the  chat paginated from the server but now we will
    // generate some dummy data
    late var experts;
    try {
      // Response response = await dio
      //     .get('chat/${id}', queryParameters: {'page': page,});
      // var data = response.data;
      // return data;
      experts = [
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Kareem Adel",
          "field": "Supply Chain",
          "online": false,
          "id": "1"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": false,
          "id": "2"
        }
      ];

      return experts;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getonlineExperts() async {
    // here is supposed to have api request that gets the  chat paginated from the server but now we will
    // generate some dummy data
    late var experts;
    try {
      // Response response = await dio
      //     .get('chat/${id}', queryParameters: {'page': page,});
      // var data = response.data;
      // return data;
      experts = [
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Kareem Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "1"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "2"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "2"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "2"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "2"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "2"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "2"
        },
        {
          "image": "man.jpg",
          "rating": "5",
          "name": "Merna Adel",
          "field": "Supply Chain",
          "online": true,
          "id": "2"
        }
      ];

      return experts;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
