import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/transacao.dart';
import 'transacao_edit.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransacaoLista extends StatefulWidget {
  @override
  _TransacaoListaState createState() => _TransacaoListaState();
}

class _TransacaoListaState extends State<TransacaoLista> {
  final CollectionReference transactionsRef =
      FirebaseFirestore.instance.collection('transactions');
  List<Transacao> transactions = []; // Armazena transações localmente

  @override
  initState() {
    super.initState();
    // Busca dados do Firestore ao iniciar o widget
    buscarTransacoes();
  }

  buscarTransacoes() async {
    try {
      final snapshot = await transactionsRef.get();
      setState(() {
        transactions = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Transacao(
            id: doc.id,
            title: data['title'],
            value: data['value'],
            date: (data['date'] as Timestamp).toDate(),
          );
        }).toList();
      });
    } catch (error) {
      // Trata erros, por exemplo, mostrando um alerta
      print('Erro ao buscar transações: $error');
    }
  }

  void onRemove(String transactionId) async {
    try {
      await transactionsRef.doc(transactionId).delete();
      // Atualiza a interface após excluir do Firestore
      buscarTransacoes();
    } catch (error) {
      print('Erro ao remover transação: $error');
    }
  }

  //lista de transações
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            'Lista de Transações',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 550,
            child: transactions.isEmpty
                ? Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Nenhuma transação cadastrada!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        child: Image.asset(
                          '../recusos/imagens/blank.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final trx = transactions[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 5,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: FittedBox(
                                child:
                                    Text(DateFormat('dd/MM').format(trx.date)),
                              ),
                            ),
                          ),
                          title: Text(
                            trx.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                'R\$${trx.value}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                DateFormat(' - dd MMM y').format(trx.date),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return TransacaoEdit(
                                          transacao: trx,
                                          onTransacaoEditada:
                                              (transacaoEditada) {
                                            setState(() {
                                              final index =
                                                  transactions.indexWhere((t) =>
                                                      t.id ==
                                                      transacaoEditada.id);
                                              if (index != -1) {
                                                transactions[index] =
                                                    transacaoEditada;
                                              }
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => onRemove(trx.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
