import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, EdgeInsets margin) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message, 
          style: const TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: margin,
        backgroundColor: const Color.fromARGB(88, 255, 255, 255), // Cor sólida de fundo
        elevation: 0, // Defina a elevação como 0 para remover a sombra
      ),
    );
  }
}
