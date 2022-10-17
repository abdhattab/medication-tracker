import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication_tracker/models/bn_screens.dart';
import 'package:medication_tracker/screens/bn_screen/home_screen.dart';
import 'package:medication_tracker/screens/bn_screen/medication_screen.dart';
import 'package:medication_tracker/screens/setting_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex=0;

 final List<BnScreen>_bnScreens=<BnScreen>[
   const BnScreen(widget:HomeScreen(),title: 'Home'),
   const BnScreen(widget:MedicationScreen(),title: 'Medication'),
   const BnScreen(widget:SettingScreen(),title: 'Settings'),
 ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar  : AppBar(
        title: Text(
          _bnScreens[_currentIndex].title,
          style: GoogleFonts.mada(
              color: const  Color(0xff3b195a), fontSize: 18, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        titleSpacing: 1,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: _bnScreens[_currentIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type:BottomNavigationBarType.shifting,


        onTap: (int currentIndex){
          setState(() {
            _currentIndex=currentIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home',backgroundColor: Color(0xff3b195a),activeIcon: Icon(Icons.home,color: Color(0xfffef647))),
          BottomNavigationBarItem(icon: Icon(Icons.medication_outlined),label: 'Medication',backgroundColor:  Color(0xff3b195a),activeIcon: Icon(Icons.medication,color: Color(0xfffef647),)),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: 'Setting',backgroundColor:  Color(0xff3b195a),activeIcon: Icon(Icons.settings,color: Color(0xfffef647),)),
        ],
      ),

    );
  }
}
