import 'package:flutter/material.dart';

class TextFromField extends StatelessWidget {
  final bool password;
  final String lavel;
  final IconData icon;
  final TextInputType inputType;
  final errorOccurred;
  final erroMessage;
  final ValueChanged<String> onChanged;

  TextFromField(
      {this.lavel,
      this.icon,
      this.inputType,
      this.password = false,
      this.onChanged,
      this.errorOccurred = false,
      this.erroMessage = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 75.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextField(
            onChanged: onChanged,
            obscureText: password,
            decoration: InputDecoration(
                //TODO: agregar el mensaje de error al indioma y al SingSate
                errorText: errorOccurred ? 'Email no valido' : null,
                labelText: lavel,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}
