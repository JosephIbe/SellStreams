import 'genres_model.dart';

/// success : true
/// msg : "All Genres Fetched"
/// genres : [{"_id":"6094c6c95b238a324097097f","title":"drama"},{"_id":"6094cac5f05aad473c60e1f3","title":"adventure"}]

class GenresResponseModel {
  bool _success;
  String _msg;
  List<GenresModel> _genres;

  bool get success => _success;
  String get msg => _msg;
  List<GenresModel> get genres => _genres;

  GenresResponseModel({
      bool success, 
      String msg, 
      List<GenresModel> genres}){
    _success = success;
    _msg = msg;
    _genres = genres;
}

  GenresResponseModel.fromJson(dynamic json) {
    _success = json["success"];
    _msg = json["msg"];
    if (json["genres"] != null) {
      _genres = [];
      json["genres"].forEach((v) {
        _genres.add(GenresModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["msg"] = _msg;
    if (_genres != null) {
      map["genres"] = _genres.map((v) => v.toJson()).toList();
    }
    return map;
  }

}