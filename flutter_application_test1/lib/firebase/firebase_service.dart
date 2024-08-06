import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_test1/firebase/firevebase_config.dart';

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: FirebaseConfig.apiKey,
        authDomain: FirebaseConfig.authDomain,
        projectId: FirebaseConfig.projectId,
        storageBucket: FirebaseConfig.storageBucket,
        messagingSenderId: FirebaseConfig.messagingSenderId,
        appId: FirebaseConfig.appId,
        measurementId: FirebaseConfig.measurementId,
      ),
    );
  }
}
