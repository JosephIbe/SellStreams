import 'cart_model.dart';

/// success : true
/// msg : "All Cart Items Fetched"
/// cart : [{"_id":"609d19def55ff44880fa34aa","movieId":"6098a97da0aebf446056df82","price":299,"total":299}]

class CartResponseModel {
  bool _success;
  String _msg;
  List<CartModel> _cart;

  bool get success => _success;
  String get msg => _msg;
  List<CartModel> get cart => _cart;

  CartResponseModel({
      bool success, 
      String msg, 
      List<CartModel> cart}){
    _success = success;
    _msg = msg;
    _cart = cart;
}

  CartResponseModel.fromJson(dynamic json) {
    _success = json["success"];
    _msg = json["msg"];
    if (json["cart"] != null) {
      _cart = [];
      json["cart"].forEach((v) {
        _cart.add(CartModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["msg"] = _msg;
    if (_cart != null) {
      map["cart"] = _cart.map((v) => v.toJson()).toList();
    }
    return map;
  }

}