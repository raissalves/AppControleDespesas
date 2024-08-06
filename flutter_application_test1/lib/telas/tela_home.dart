import 'package:flutter/material.dart';
import 'package:flutter_application_test1/componentes/grafico.dart';
import 'package:flutter_application_test1/componentes/transacao_form.dart';
import 'package:flutter_application_test1/componentes/transacao_lista.dart';
import 'package:flutter_application_test1/models/transacao.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacao> _transactions = [];
  List<Transacao> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double valor, DateTime data) {
    final newTransaction = Transacao(
      id: Random().nextDouble().toString(),
      title: title,
      value: valor,
      date: data,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _atualizarTransacao(
      String id, String novoTitulo, double novoValor, DateTime novaData) {
    final index = _transactions.indexWhere((tx) => tx.id == id);
    if (index >= 0) {
      setState(() {
        _transactions[index] = Transacao(
          id: id,
          title: novoTitulo,
          value: novoValor,
          date: novaData,
        );
      });
    }
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  void _reloadPage() {
    setState(() {
      // Força a reconstrução da página
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        title: Row(
          children: [
            Column(
              children: [
                Image.asset(
                  '../recusos/imagens/OrcaMente.png',
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Column(
              children: [
                Text(
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadPage,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Grafico(),
            const SizedBox(height: 20),
            TransacaoLista(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
