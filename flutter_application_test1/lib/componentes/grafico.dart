import 'package:flutter/material.dart';
import 'package:flutter_application_test1/componentes/grafico_barra.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Grafico extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Grafico(this.recentTransaction, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _totalSemana {
    return groupedTransactions.fold(0.0, (sum, trx) {
      return sum + (trx['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((trx) {
            return Flexible(
              fit: FlexFit.tight,
              child: GraficoBarra(
                dia: trx['day'] as String,
                valor: trx['value'] as double,
                porcentagem: _totalSemana == 0
                    ? 0
                    : (trx['value'] as double) / _totalSemana,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
