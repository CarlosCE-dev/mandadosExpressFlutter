import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final Color fontColor;

  const CustomInput({
    @required this.icon, 
    @required this.placeholder, 
    @required this.textController,
    this.fontColor = Colors.black87, 
    this.keyboardType = TextInputType.text, 
    this.isPassword = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom:20),
      padding: EdgeInsets.only( top: 5, left:20, bottom: 5, right: 20 ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0,5),
            blurRadius: 5
          )
        ]
      ),
      child: TextFormField(
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle( fontSize: 18, color: this.fontColor ),
        decoration: InputDecoration(
          icon: Icon( this.icon ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.placeholder,
        ),
      ),
    );
  }
}