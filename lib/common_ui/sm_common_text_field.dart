import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:send_money/utils/extensions.dart';

class SMCommonTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const SMCommonTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
  });

  @override
  State<SMCommonTextField> createState() => _SMCommonTextFieldState();
}

class _SMCommonTextFieldState extends State<SMCommonTextField> {
  late bool _isObscure;

  @override
  void initState() {
    widget.controller?.addListener(_onTextChanged);
    _isObscure = widget.obscureText;
    super.initState();
  }

  void _onTextChanged() {
    widget.onChanged?.call(widget.controller?.text ?? '');
  }

  void _toggleObscureText() {
    setState(() => _isObscure = !_isObscure);
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: _isObscure,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: context.theme.primaryColor, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey),
                onPressed: _toggleObscureText)
            : widget.suffixIcon,
      ),
    );
  }
}
