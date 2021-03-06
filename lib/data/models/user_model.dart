import 'package:flutter/material.dart';

class UserModel {

  final String id;
  final String username;
  final String email;
  final String phone;

  const UserModel({
    this.id,
    @required this.email,
    @required this.username,
    @required this.phone,
  });

  UserModel copyWith({String id, String username, String email, String phone}){
    if (
        (id == null) || identical(id, this.id) &&
        (username == null) || identical(id, this.username) &&
        (email == null || identical(email, this.email)) &&
        (phone == null || identical(phone, this.phone))) {
      return this;
    }

    return new UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  static const empty = UserModel(email: '', username: null, phone: null, id: '');

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, phone: $phone}';
  }

  factory UserModel.fromJSON(Map<String, dynamic> map){
    return new UserModel(
      id:map['_id'],
      username:map['username'],
      email:map['email'],
      phone:map['phone'],
    );
  }

  Map<String, dynamic> toJSON(){
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }

}