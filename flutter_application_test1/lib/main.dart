import 'package:flutter/material.dart';
import 'package:flutter_application_test1/componentes/transacao_form.dart';
import 'package:flutter_application_test1/componentes/transacao_lista.dart';
import 'dart:math';
import 'componentes/grafico.dart';
import 'models/transaction.dart';

main() => runApp(DespesasApp());

class DespesasApp extends StatelessWidget {
  DespesasApp({Key? key}) : super(key: key);
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      //tema do app para definir cores personalizadas do app e fontes
      theme: ThemeData(
        primaryColor: Colors.blue,
        primaryIconTheme: const IconThemeData(color: Colors.white),
        secondaryHeaderColor: Color.fromARGB(255, 153, 187, 246),
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double valor, DateTime data) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: valor,
      date: data,
    );
    //verificar se existe um id
    if (newTransaction.id == null) {
      _atualizarTransacao(newTransaction.id!, title, valor, data);
    } else {
      setState(() {
        _transactions.add(newTransaction);
      });
    }

    Navigator.of(context).pop();
  }

  _removeTransacao(String id) {
    setState(() {
      _transactions.removeWhere((trx) => trx.id == id);
    });
  }

  _atualizarTransacao(
      String id, String novoTitulo, double novoValor, DateTime novaData) {
    final index = _transactions.indexWhere((tx) => tx.id == id);
    if (index >= 0) {
      setState(() {
        _transactions[index] = Transaction(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        centerTitle: false,
        title: const Text(
          'Despesas Pessoais',
          style: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Grafico(_recentTransactions),
            TransacaoLista(
                _transactions, _removeTransacao, (id) => _atualizarTransacao),
          ], //children
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        hoverColor: Theme.of(context).primaryColorLight,
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
