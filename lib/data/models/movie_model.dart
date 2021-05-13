import 'genres_model.dart';

/// genres : ["6097bf7aa0aebf446056df7e","6097bf82a0aebf446056df7f"]
/// _id : "6097bfc4a0aebf446056df80"
/// title : "The Transporter 2"
/// director : "Christopher Nolan"
/// price : "1599.60"
/// rating : "9.8"
/// synopsis : "A very long synopsis about a movie from a world class director"
/// imageURL : "https://empty-bouquet.s3.af-south-1.amazonaws.com/1620557752156_play_list.jpg"
/// videoURL : "https://empty-bouquet.s3.af-south-1.amazonaws.com/1620557755185_sport_eco_add_program_sim_vid.mp4"

class Movies {
  String _id;
  String _title;
  String _director;
  String _price;
  String _rating;
  String _synopsis;
  String _imageURL;
  String _videoURL;
  List<GenresModel> _genres;

  String get id => _id;
  String get title => _title;
  String get director => _director;
  String get price => _price;
  String get rating => _rating;
  String get synopsis => _synopsis;
  String get imageURL => _imageURL;
  String get videoURL => _videoURL;
  List<GenresModel> get genres => _genres;

  Movies({
    List<GenresModel> genres,
    String id,
    String title,
    String director,
    String price,
    String rating,
    String synopsis,
    String imageURL,
    String videoURL}){
    _genres = genres;
    _id = id;
    _title = title;
    _director = director;
    _price = price;
    _rating = rating;
    _synopsis = synopsis;
    _imageURL = imageURL;
    _videoURL = videoURL;
  }

  Movies.fromJson(dynamic json) {
    _genres = json["genres"] != null ? json["genres"].cast<GenresModel>() : [];
    _id = json["_id"];
    _title = json["title"];
    _director = json["director"];
    _price = json["price"];
    _rating = json["rating"];
    _synopsis = json["synopsis"];
    _imageURL = json["imageURL"];
    _videoURL = json["videoURL"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["genres"] = _genres;
    map["_id"] = _id;
    map["title"] = _title;
    map["director"] = _director;
    map["price"] = _price;
    map["rating"] = _rating;
    map["synopsis"] = _synopsis;
    map["imageURL"] = _imageURL;
    map["videoURL"] = _videoURL;
    return map;
  }

}