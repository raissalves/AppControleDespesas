import 'package:flutter/material.dart';
import 'package:flutter_application_test1/utils/app_colors.dart';

class ThemeConfig {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 1, 87, 41),
      primaryColorLight: const Color.fromARGB(255, 52, 192, 31),
      hintColor: const Color.fromARGB(255, 52, 192, 31),
      primaryIconTheme: const IconThemeData(color: Colors.white),
      secondaryHeaderColor: const Color.fromARGB(255, 153, 246, 179),
      fontFamily: 'QuickSand',
      textTheme: TextTheme(
        displayLarge: TextStyle(
            fontFamily: 'QuickSand', fontSize: 32, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontFamily: 'QuickSand', fontSize: 16),
        bodyMedium: TextStyle(fontFamily: 'QuickSand', fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'QuickSand',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget BotaoSecundario({
    required VoidCallback onPressed,
    required String texto,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Estilo do seu botão secundário
        backgroundColor: const Color.fromARGB(255, 1, 87, 41),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(texto),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PrimaryButton({
    Key? key,
    this.onPressed,
    required this.text,
    required TextAlign textAlign,
  }) : super(key: key);

  final BorderRadius _borderRadius =
      const BorderRadius.all(Radius.circular(24.0));

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: onPressed != null
                ? AppColors.greenGradient
                : AppColors.greyGradient,
          ),
        ),
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: onPressed,
          child: Align(
            child: Text(
              text,
            ),
          ),
        ),
      ),
    );
  }
}

//altera todos o container do projeto
class AppContainer extends StatelessWidget {
  final Widget child;
  const AppContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 1, 87, 41),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
      child: child,
    );
  }
}
