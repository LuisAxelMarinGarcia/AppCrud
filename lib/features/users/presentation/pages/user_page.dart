import 'package:flutter/material.dart';
import 'package:crud/features/users/presentation/widgets/user_form.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/user_list');
            },
          ),
        ],
      ),
      body: UserForm(),
    );
  }
}
