import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordInputField extends StatefulWidget {
  final void Function(String)? _onChanged;
  final String? Function(String?)? _validator;
  final String? _hintText;
  final TextInputAction? _textInputAction;
  final List<TextInputFormatter>? _inputFormatters;

  const PasswordInputField({
    super.key,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    TextInputAction? textInputAction,
    String? hintText,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? passwordController,
  })  : _onChanged = onChanged,
        _validator = validator,
        _textInputAction = textInputAction,
        _hintText = hintText,
        _inputFormatters = inputFormatters;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget._onChanged,
      validator: widget._validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: widget._textInputAction,
      inputFormatters: widget._inputFormatters,
      obscureText: _isObscure,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        hintText: widget._hintText ?? "Password",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          child: Icon(
            _isObscure ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
            size: 22,
          ),
        ),
      ),
    );
  }
}
