import 'package:flutter/material.dart';
import 'package:flutter_application_test1/telas/tela_home.dart';
import 'package:flutter_application_test1/utils/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 1, 87, 41),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 350),
                Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      '../recusos/imagens/OrcaMente.png',
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      'OrçaMente',
                      style: TextStyle(
                        fontFamily: 'Rowdies',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                '../recusos/imagens/money.png',
                height: 300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Gaste de forma inteligente',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'e economize mais!',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ThemeConfig.BotaoSecundario(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  },
                  texto: 'Começar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
