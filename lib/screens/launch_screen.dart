import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication_tracker/preferences/shared_pref_controller.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LanchScreenState();
}

class _LanchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000),(){
      String route=SharedPrefController().loggedIn ? 'BottomNavigationScreen' : 'OutBoardingScreen';

      Navigator.pushReplacementNamed(context, route) ;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient:  LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [ Color(0xff00D7FF), Color(0xff0096FF)],
            )),
        child: Center(
          child: Text(
            'Medication Tracker',
            style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),

      ),

    );
  }
}
