class Message {
  String? message;
  String? from;

  Message({this.message, this.from});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    from = json['from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['from'] = this.from;
    return data;
  }
}
