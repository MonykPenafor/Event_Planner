import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message, 
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(70.0), 
        backgroundColor: color, 
        elevation: 0, // remover the shadow

      ),
    );
  }
}
