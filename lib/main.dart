import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crud/features/users/presentation/bloc/user_bloc.dart';
import 'package:crud/features/users/presentation/pages/user_list_page.dart';
import 'package:crud/features/users/presentation/pages/update_user_page.dart';
import 'package:crud/features/users/presentation/pages/user_page.dart';
import 'injection_container.dart' as di;

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
