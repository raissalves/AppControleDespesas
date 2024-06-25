import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransacaoLista extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final void Function(String) onUpdate;

  const TransacaoLista(this.transactions, this.onRemove, this.onUpdate);

  //lista de transações
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,

      //operação ternaria para verificar se a lista de transações está vazia
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
                  height: 100,
                  child: Image.asset(
                    'recusos/imagens/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )

          //caso a lista de transações não esteja vazia, será exibida a lista de transações
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
                          child: Text(DateFormat('dd/MM').format(trx.date)),
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
                    //botão de exclusão de transação
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => onUpdate(trx.id),
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
    );
  }
}
