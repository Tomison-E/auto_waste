// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_waste/model/users.dart';
class Register extends StatefulWidget {
  const Register({ Key key }) : super(key: key);

  static const String routeName = '/material/text-form-field';

  @override
  RegisterState createState() => new RegisterState();
}



class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

class RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Users person = new Users();
  String _selected;
  String _state;
  String _lga;
  String _notification;
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  bool _autoValidate = false;
  bool _formWasEdited = false;
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<FormFieldState<String>>();
  final _UsNumberTextInputFormatter _phoneNumberFormatter = new _UsNumberTextInputFormatter();
  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if(_selected == null || _state == null || _lga==null){
      _autoValidate = true; // Start validating on every change.
      showInSnackBar('Please select an option from the select fields.');
    }
    else if (!form.validate()) {
      _autoValidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${person.name}\'s phone number is ${person.number}');
      print(person.password);
    }
  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  String _validateEmail(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Email is required.';
    return null;
  }

  String _validatePhoneNumber(String value) {
    _formWasEdited = true;
    final RegExp phoneExp = new RegExp(r'^\d\d\d\-\d\d\d\-\d\d\d\d\d$');
    if (!phoneExp.hasMatch(value))
      return '###-###-##### - Enter a NG phone number.';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    if (passwordField.value != value)
      return 'The passwords don\'t match';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: const Text('This form has errors'),
          content: const Text('Really leave this form?'),
          actions: <Widget> [
            new FlatButton(
              child: const Text('YES'),
              onPressed: () { Navigator.of(context).pop(true); },
            ),
            new FlatButton(
              child: const Text('NO'),
              onPressed: () { Navigator.of(context).pop(false); },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Register'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _warnUserAboutInvalidData,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new Row(children: <Widget>[
                  new Icon(Icons.title),
                  const SizedBox(width: 24.0),
                  new DropdownButton(items: <String>["Mr","Mrs","Miss"].map((String value){
                    return new DropdownMenuItem<String>(child: new Text(value),value: value);
                  }).toList(), onChanged: (String val){
                    setState(() {
                      _selected=val;
                      person.title=_selected;
                    });
                  },value:_selected,hint:Text("Title")),
                ],),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.person),
                    hintText: 'Input your FirstName?',
                    labelText: 'First Name *',
                  ),
                  onSaved: (String value) { person.name = value; print("layouts"); },
                  validator: _validateName,
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.person),
                    hintText: 'Input your LastName',
                    labelText: 'Last Name *',
                  ),
                  onSaved: (String value) { person.lastName = value; print("layouts"); },
                  validator: _validateName,
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Tell us where you live',
                    helperText: 'Your Home Adress.',
                    labelText: 'Home Location',
                    prefixText: 'No ',
                  ),
                  maxLines: 3,
                  onSaved: (String value)=>person.address=value,
                ),
                const SizedBox(height: 24.0),
                new Row(children: <Widget>[
                  new Icon(Icons.location_city),
                  const SizedBox(width: 24.0),
                  new DropdownButton(items: <String>["OGUN","LAGOS","EKITI"].map((String value){
                    return new DropdownMenuItem<String>(child: new Text(value),value: value);
                  }).toList(), onChanged: (String val){
                    setState(() {
                      _state=val;
                      person.state=_state;
                    });
                  },value:_state,hint:Text("State")),
                ],),
                const SizedBox(height: 24.0),
                new Row(children: <Widget>[
                  new Icon(Icons.add_location),
                  const SizedBox(width: 24.0),
                  new DropdownButton(items: <String>["OWODE","ABEOKUTA","MOWE"].map((String value){
                    return new DropdownMenuItem<String>(child: new Text(value),value: value);
                  }).toList(), onChanged: (String val){
                    setState(() {
                      _lga=val;
                      person.lga=_lga;
                    });
                  },value:_lga,hint:Text("Lga")),
                ],),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.phone),
                    hintText: 'Where can we reach you?',
                    labelText: 'Phone Number *',
                    prefixText: '(+234) ',
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (String value) { person.number = value; },
                  validator: _validatePhoneNumber,
                  // TextInputFormatters are applied in sequence.
               /*   inputFormatters: <TextInputFormatter> [
                    WhitelistingTextInputFormatter.digitsOnly,
                    // Fit the validating format.
                    _phoneNumberFormatter,
                  ],*/
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: const Icon(Icons.email),
                    hintText: 'Your email address',
                    labelText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) { person.email = value; },
                  validator: _validateEmail,
                ),
                const SizedBox(height: 24.0),
                new Row(children: <Widget>[
                  new Icon(Icons.notifications),
                  const SizedBox(width: 24.0),
                  new DropdownButton(items: <String>["SMS","EMAIL","BOTH","NIL"].map((String value){
                    return new DropdownMenuItem<String>(child: new Text(value),value: value);
                  }).toList(), onChanged: (String val){
                    setState(() {
                      _notification=val;
                      person.notification=_notification;
                    });
                  },value:_notification,hint:Text("Notification")),
                ],),
                const SizedBox(height: 24.0),
                new PasswordField(
                  fieldKey: _passwordFieldKey,
                  helperText: 'No more than 8 characters.',
                  labelText: 'Password *',
                  onFieldSubmitted: (String value) {
                    setState(() {
                      person.password = value;
                      print(person.password);
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  enabled: person.password != null && person.password.isNotEmpty,
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    labelText: 'Re-type password',
                  ),
                  maxLength: 8,
                  obscureText: true,
                  controller: passwordController,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24.0),
                new Center(
                  child: new RaisedButton(
                    child: const Text('SUBMIT'),
                    onPressed: _handleSubmitted,
                  ),
                ),
                const SizedBox(height: 24.0),
                new Text(
                    '* indicates required field',
                    style: Theme.of(context).textTheme.caption
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Format incoming numeric text to fit the format of (###) ###-#### ##...
class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = new StringBuffer();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1)
        selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3)
        selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6)
        selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      if (newValue.selection.end >= 10)
        selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
