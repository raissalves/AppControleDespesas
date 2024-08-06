import 'package:flutter/material.dart';
import 'package:flutter_application_test1/telas/tela_home.dart';
import 'package:flutter_application_test1/utils/app_theme.dart';

class IntegracaoPage extends StatelessWidget {
  const IntegracaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
            ),
            //color: Theme.of(context).backgroundColor,
            child: Image.asset('../recusos/imagens/money.png'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Gaste de forma inteligente',
        ),
        const Text(
          'e economize mais!',
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
            top: 16.0,
            bottom: 4.0,
          ),
          child: PrimaryButton(
            text: 'Vamos Lá!',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    ));
  }
}
