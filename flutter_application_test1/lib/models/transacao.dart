class Transacao {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transacao({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
      'date': date, // O Firestore aceita objetos DateTime diretamente
    };
  }
}
