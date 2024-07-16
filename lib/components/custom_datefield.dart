import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Icon prefixIcon;

  const CustomDateField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData customTheme = ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.blueGrey, // Header background color
        onPrimary: Colors.white, // Header text color
        onSurface: Colors.blueGrey, // Body text color
      ),
      dialogBackgroundColor: Colors.white, // Background color
      
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
