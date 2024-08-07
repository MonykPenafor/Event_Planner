import 'package:flutter/material.dart';


class PasswordField extends StatefulWidget {
  final Function(String) onPasswordChanged;
  const PasswordField({super.key, required this.onPasswordChanged});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      widget.onPasswordChanged(_passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _isObscured,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.fingerprint),
        label: const Text("Password"),
        suffixIcon: IconButton(
          icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.2)
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.7)
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
