class User {
  final String id;
  final String name;
  final String surname;
  final int age;
  final int cellphone;
  final String email;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.cellphone,
    required this.email,
    required this.password,
  });

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
