import 'package:flutter/material.dart';
import 'package:flutter_application_test1/firebase/firebase_service.dart';
import 'package:flutter_application_test1/telas/tela_home.dart';
import 'package:flutter_application_test1/telas/tela_inicio.dart';
import 'package:flutter_application_test1/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Firebase usando as configurações
  await FirebaseService.initialize();
  runApp(DespesasApp());
}

class DespesasApp extends StatelessWidget {
  DespesasApp({super.key});

  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OrçaMente',
      theme: ThemeConfig.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/transacao_lista': (context) => MyHomePage(),
      },
    );
  }
}
