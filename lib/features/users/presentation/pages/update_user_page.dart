import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/users/presentation/bloc/user_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/user.dart';

class UpdateUserPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final ageController = TextEditingController();
  final cellphoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final uuid = const Uuid();

  UpdateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    nameController.text = user.name;
    surnameController.text = user.surname;
    ageController.text = user.age.toString();
    cellphoneController.text = user.cellphone.toString();
    emailController.text = user.email;
    passwordController.text = user.password;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Usuario actualizado exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error al actualizar usuario: ${state.message}'),
                backgroundColor: Colors.red,
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
                        final updatedUser = User(
                          id: user.id,
                          name: nameController.text,
                          surname: surnameController.text,
                          age: int.parse(ageController.text),
                          cellphone: int.parse(cellphoneController.text),
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        print('Updating user: ${updatedUser.name}');
                        context.read<UserBloc>().add(UpdateUserEvent(user: updatedUser));
                      } else {
                        print('Form validation failed');
                      }
                    },
                    child: const Text('Update User'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
