import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  String hint;
  IconData icon;
  TextEditingController textController;
   TextWidget({
    Key? key, required this.hint,required this.icon,required this.textController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,maxLength: 20,
      style: const TextStyle(color: Colors.blue),
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon:Icon(icon),
          hintStyle: GoogleFonts.adventPro(
              fontSize: 10, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
            const BorderSide(width: 2, color: Colors.blue),
            //
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blue,
              ))),
    );
  }

}
