import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/users/presentation/bloc/user_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/user.dart';

class UserForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();
  final cellphoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final uuid = const Uuid();

  UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario creado exitosamente'),
              backgroundColor: Colors.green, // Fondo verde
            ),
          );
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al crear usuario: ${state.message}'),
              backgroundColor: Colors.red, // Fondo rojo para errores
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
                TextFormField(controller: surnameController, decoration: const InputDecoration(labelText: 'Surname')),
                TextFormField(controller: ageController, decoration: const InputDecoration(labelText: 'Age')),
                TextFormField(controller: cellphoneController, decoration: const InputDecoration(labelText: 'Cellphone')),
                TextFormField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
                TextFormField(controller: passwordController, decoration: const InputDecoration(labelText: 'Password')),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final user = User(
                        id: uuid.v4(),
                        name: nameController.text,
                        surname: surnameController.text,
                        age: int.parse(ageController.text),
                        cellphone: int.parse(cellphoneController.text),
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      print('Creating user: ${user.name}');
                      context.read<UserBloc>().add(CreateUserEvent(user: user));
                    } else {
                      print('Form validation failed');
                    }
                  },
                  child: const Text('Create User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
