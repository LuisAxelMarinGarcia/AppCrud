import 'package:crud/features/users/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.surname,
    required super.age,
    required super.cellphone,
    required super.email,
    required super.password,
  });

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

  @override
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
