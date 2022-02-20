import 'package:flutter/material.dart';

class PrimaryTextFormField extends StatefulWidget {
  //TODO:: make is stless
  PrimaryTextFormField({
    Key? key,
    this.isPasswordField = false,
    required this.labelText,
    required this.hintText,
    required this.focusNode,
    required this.onEditingComplete,
    required this.controller,
    this.keyboardType = TextInputType.emailAddress,
  }) : super(key: key);

  bool isPasswordField;
  String labelText;
  String hintText;
  FocusNode focusNode;
  Function() onEditingComplete;
  TextEditingController controller;
  TextInputType keyboardType;

  @override
  State<PrimaryTextFormField> createState() => _PrimaryTextFormFieldState();
}

class _PrimaryTextFormFieldState extends State<PrimaryTextFormField> {
  TextInputAction? keyboardType;

  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: !_isLoading,
      decoration: InputDecoration(
        suffixIcon: widget.isPasswordField
            ? GestureDetector(
                onTap: () {
                  isObscure = !isObscure; // show and hide password
                  setState(() {});
                },
                child: !isObscure
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null,
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey.withOpacity(.7),
        ),
      ),
      obscureText: widget.isPasswordField && !isObscure,
      autocorrect: false,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
    );
  }
}
