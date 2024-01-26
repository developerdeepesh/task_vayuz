import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_vayuz/view/todo_list.dart';
import 'package:task_vayuz/view_model/todo_view_model.dart';

import 'view/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoViewModel()),
      ],
      child: const MaterialApp(
        title: 'Todo Vayuz',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        // home: Vault(),
      ),
    );
  }
}
