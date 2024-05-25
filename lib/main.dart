import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/users/presentation/bloc/user_bloc.dart';
import 'package:crud/features/users/presentation/pages/user_list_page.dart';
import 'package:crud/features/users/presentation/pages/update_user_page.dart';
import 'package:crud/features/users/presentation/widgets/network_status_widget.dart'; // Importa el widget
import 'injection_container.dart' as di;
import 'package:crud/features/users/domain/entities/user.dart'; // Importa la entidad User

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<UserBloc>()..add(GetAllUsersEvent())),
      ],
      child: MaterialApp(
        title: 'Flutter CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const UserPage(),
          '/user_list': (context) => const UserListPage(),
          '/update_user': (context) => UpdateUserPage(),
        },
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: Column(
        children: [
          NetworkStatusWidget(), // Añade el widget de estado de la red
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/user_list');
                    },
                    child: const Text('Listar Usuarios'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CreateUserForm(), // Añade el formulario de creación de usuario
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateUserForm extends StatefulWidget {
  const CreateUserForm({super.key});

  @override
  _CreateUserFormState createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cellphoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _ageController.dispose();
    _cellphoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _createUser() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = User(
        id: '', // Aquí puedes asignar un valor vacío o generar un ID único según sea necesario
        name: _nameController.text,
        surname: _surnameController.text,
        age: int.parse(_ageController.text),
        cellphone: int.parse(_cellphoneController.text),
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Aquí llamas al Bloc para crear el usuario
      context.read<UserBloc>().add(CreateUserEvent(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el nombre';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _surnameController,
            decoration: const InputDecoration(labelText: 'Apellido'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el apellido';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(labelText: 'Edad'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa la edad';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _cellphoneController,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el teléfono';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa el email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa la contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _createUser,
            child: const Text('Crear Usuario'),
          ),
        ],
      ),
    );
  }
}
