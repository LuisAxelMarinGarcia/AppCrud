import 'package:crud/features/users/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String surname,
    required int age,
    required int cellphone,
    required String email,
    required String password,
  }) : super(
    id: id,
    name: name,
    surname: surname,
    age: age,
    cellphone: cellphone,
    email: email,
    password: password,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      age: json['age'],
      cellphone: json['cellphone'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'age': age,
      'cellphone': cellphone,
      'email': email,
      'password': password,
    };
  }
}
