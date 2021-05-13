import 'movie_model.dart';

/// success : true
/// msg : "All Movies Fetched"
/// movies : [{"genres":["6097bf7aa0aebf446056df7e","6097bf82a0aebf446056df7f"],"_id":"6097bfc4a0aebf446056df80","title":"The Transporter 2","director":"Christopher Nolan","price":"1599.60","rating":"9.8","synopsis":"A very long synopsis about a movie from a world class director","imageURL":"https://empty-bouquet.s3.af-south-1.amazonaws.com/1620557752156_play_list.jpg","videoURL":"https://empty-bouquet.s3.af-south-1.amazonaws.com/1620557755185_sport_eco_add_program_sim_vid.mp4"}]

class MovieResponseModel {
  bool _success;
  String _msg;
  List<Movies> _movies;

  bool get success => _success;
  String get msg => _msg;
  List<Movies> get movies => _movies;

  MovieResponseModel({
      bool success, 
      String msg, 
      List<Movies> movies}){
    _success = success;
    _msg = msg;
    _movies = movies;
}

  MovieResponseModel.fromJson(dynamic json) {
    _success = json["success"];
    _msg = json["msg"];
    if (json["movies"] != null) {
      _movies = [];
      json["movies"].forEach((v) {
        _movies.add(Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["msg"] = _msg;
    if (_movies != null) {
      map["movies"] = _movies.map((v) => v.toJson()).toList();
    }
    return map;
  }

}