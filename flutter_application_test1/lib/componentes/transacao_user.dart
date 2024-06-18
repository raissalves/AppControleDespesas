import 'dart:math';
import 'package:flutter/material.dart';
import 'transacao_form.dart';
import 'transacao_lista.dart';
import '../models/transaction.dart';

class TransacaoUser extends StatefulWidget {
  const TransacaoUser({Key? key}) : super(key: key);

  @override
  State<TransacaoUser> createState() {
    return _TransactionUserState();
  }
}

class _TransactionUserState extends State<TransacaoUser> {
  

  //para criar uma nova transação essa função é chamada,

  _addTransacao(String title, double value) {
    final newTransacao = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    // aqui cria a lista de transação e atualiza
    setState(() {
      _TransactionUserState.add(newTransacao);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransacaoLista(_transactions),
        TransacaoForm(_addTransacao),
      ],
    );
  }
}
