import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text(
              'Thanks for using our Application ♥ ',
              style: GoogleFonts.aBeeZee(),
            ),
            const Divider(thickness: 0.5,color: Colors.red),

            Text(
              'That\'s app under developing in the next time I will make app more interactive .',
              style: GoogleFonts.aBeeZee(
                color: const Color(0xff0096FF)
              ),

            ),

            const Divider(thickness: 0.5,color: Colors.red),
            const Spacer(),


            Text('Application Version 1.0.0',style: GoogleFonts.aBeeZee(
              fontSize:10,
              fontWeight: FontWeight.w300,
            ),),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
