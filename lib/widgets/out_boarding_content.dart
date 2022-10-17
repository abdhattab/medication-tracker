import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutBoardingWidget extends StatelessWidget {
  const OutBoardingWidget({
    Key? key, required this.image, required this.title, required this.content,
  }) : super(key: key);
  final String? image;
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33,vertical: 33),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image!,fit: BoxFit.cover),
          const SizedBox(height: 36),
          Text(
            title!,
            style: GoogleFonts.nunito(
                color: Colors.blue.shade900, fontWeight: FontWeight.bold,fontSize: 20),
          ),
          const SizedBox(height: 17),
           Text('''$content''',textAlign: TextAlign.center,),


        ],
      ),
    );
  }
}