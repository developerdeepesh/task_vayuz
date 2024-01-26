class TodoModel {
  int? tId;
  String? title;
  String? description;
  String? date;


  TodoModel({this.tId,this.title, this.description, this.date});

  TodoModel.fromJson(Map<String,dynamic> json){
    tId=json["tId"];
    title=json["title"];
    description=json["description"]??"";
    date=json["date"]??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tId'] = tId;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}
