/// _id : "609d19def55ff44880fa34aa"
/// movieId : "6098a97da0aebf446056df82"
/// price : 299
/// total : 299

class CartModel {
  String _id;
  String _movieId;
  int _price;
  int _total;

  String get id => _id;
  String get movieId => _movieId;
  int get price => _price;
  int get total => _total;

  CartModel({
    String id,
    String movieId,
    int price,
    int total}){
    _id = id;
    _movieId = movieId;
    _price = price;
    _total = total;
  }

  CartModel.fromJson(dynamic json) {
    _id = json["_id"];
    _movieId = json["movieId"];
    _price = json["price"];
    _total = json["total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["movieId"] = _movieId;
    map["price"] = _price;
    map["total"] = _total;
    return map;
  }

}