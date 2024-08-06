import 'package:flutter/material.dart';
import 'package:flutter_application_test1/telas/tela_home.dart';
import 'package:intl/intl.dart';
import '../models/transacao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransacaoEdit extends StatefulWidget {
  final Transacao? transacao;
  final Function(Transacao) onTransacaoEditada;

  TransacaoEdit({this.transacao, required this.onTransacaoEditada});

  @override
  _TransacaoEditState createState() => _TransacaoEditState();
}

class _TransacaoEditState extends State<TransacaoEdit> {
  final _formKey = GlobalKey<FormState>();
  final CollectionReference transactionsRef =
      FirebaseFirestore.instance.collection('transactions');
  late TextEditingController _tituloController;
  late TextEditingController _valorController;
  DateTime? _dataSelecionada;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.transacao?.title);
    _valorController = TextEditingController(
        text: widget.transacao?.value != null
            ? widget.transacao!.value.toString()
            : '');
    _dataSelecionada = widget.transacao?.date;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final transactionId = widget.transacao?.id;
      final novaTransacao = Transacao(
        id: transactionId ?? '',
        title: _tituloController.text,
        value: double.tryParse(_valorController.text) ?? 0.0,
        date: _dataSelecionada!,
      );

      try {
        if (transactionId != null) {
          await transactionsRef
              .doc(transactionId)
              .update(novaTransacao.toMap());
        } else {
          // Se transactionId for null, significa que é uma nova transação
          // Lidar com a criação de uma nova transação (se necessário)
        }
        widget.onTransacaoEditada(novaTransacao);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } catch (error) {
        // Tratar o erro de atualização no Firestore
        print('Erro ao editar a transação: $error');
      }
    }
  }

  void _apresentarDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Título'),
                controller: _tituloController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um título';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                controller: _valorController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // Use onSubmitted para que o teclado numérico feche automaticamente
                //onSubmitted: (_) => _submitForm(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um valor numérico válido';
                  }
                  return null;
                },
              ),
              Container(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _dataSelecionada == null
                            ? 'Nenhuma data selecionada!'
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_dataSelecionada!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _apresentarDataPicker,
                      child: Text(
                        'Escolher Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Salvar Transação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
