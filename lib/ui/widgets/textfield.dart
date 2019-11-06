import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextField extends StatefulWidget {
  TextField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onChange,
    this.inputType,
    this.icon,
    this.obscureText,
    this.prefixText,
    this.suffixText,
    this.maxLength,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final TextInputType inputType;
  final Icon icon;
  final String prefixText;
  final String suffixText;
  bool obscureText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChange;
  final int maxLength;

  @override
  _TextFieldState createState() => new _TextFieldState();
}

class _TextFieldState extends State<TextField> {

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: widget.obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onChange,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              widget.obscureText = !widget.obscureText;
            });
          },
          child: new Icon(widget.obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}