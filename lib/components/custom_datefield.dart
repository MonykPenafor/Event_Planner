import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? icon;

  const CustomDateField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

    final ThemeData customTheme = ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.blueGrey, 
        onPrimary: Colors.white, 
        onSurface: Colors.blueGrey, 
      ),
      dialogBackgroundColor: Colors.white, 
    );

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: customTheme,
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      controller.text = formattedDate;
    }

      },
      child: AbsorbPointer(
        child: Container(
          margin: const EdgeInsets.only(top: 10), // Margem de 5 pixels acima
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w600,
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.blueGrey[300],
              ),
              fillColor: Color.fromARGB(255, 209, 234, 250),  // Cor de fundo leve
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                child: Icon(
                  icon,
                  color: Colors.blue,
                  size: 20.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none, // Remove as bordas
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none, // Remove as bordas ao focar
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none, // Remove as bordas ao erro
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none, // Remove as bordas ao focar com erro
              ),
            ),
            style: const TextStyle(
              color: Colors.blueGrey, // Estilo do texto digitado
            ),
          ),
        ),
      ),
    );
  }
}
