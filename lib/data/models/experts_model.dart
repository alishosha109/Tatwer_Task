class Expert {
  String? image;
  String? rating;
  String? name;
  String? field;
  String? id;
  bool? online;

  Expert(
      {this.image, this.rating, this.name, this.field, this.online, this.id});

  Expert.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    rating = json['rating'];
    name = json['name'];
    field = json['field'];
    online = json['online'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['name'] = this.name;
    data['field'] = this.field;
    data['online'] = this.online;
    data['id'] = this.id;
    return data;
  }
}
