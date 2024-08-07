import 'package:flutter/material.dart';

class CustomSnackBar {


  static void show(BuildContext context, String message, bool? success) {

    Color snackbarColor = Colors.black;

    if(success != null){
      snackbarColor = success ? const Color.fromARGB(255, 41, 43, 41) : const Color.fromARGB(255, 146, 22, 13);
    }

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
        backgroundColor: snackbarColor,
        elevation: 0, // remover the shadow

      ),
    );
  }
}
