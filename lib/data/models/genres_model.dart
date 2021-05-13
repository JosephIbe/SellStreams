/// _id : "6094c6c95b238a324097097f"
/// title : "drama"

class GenresModel {
  String _id;
  String _title;

  String get id => _id;
  String get title => _title;

  GenresModel({
    String id,
    String title}){
    _id = id;
    _title = title;
  }

  GenresModel.fromJson(dynamic json) {
    _id = json["_id"];
    _title = json["title"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["title"] = _title;
    return map;
  }

}