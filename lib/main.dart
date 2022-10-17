import 'package:flutter/material.dart';
import 'package:medication_tracker/database/db_controller.dart';
import 'package:medication_tracker/noification/notification_services.dart';
import 'package:medication_tracker/preferences/shared_pref_controller.dart';
import 'package:medication_tracker/screens/bn_screen/bottom_navigation_screen.dart';
import 'package:medication_tracker/screens/bn_screen/home_screen.dart';
import 'package:medication_tracker/screens/out_boarding_screen/out_boarding_screen.dart';
import 'screens/launch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await DbController().initDatabase();
  await SharedPrefController().initPref();



  runApp(const MedicationTracker());
}

class MedicationTracker extends StatefulWidget {
  const MedicationTracker({Key? key}) : super(key: key);

  @override
  State<MedicationTracker> createState() => _MedicationTrackerState();
}

class _MedicationTrackerState extends State<MedicationTracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'LaunchScreen',
      theme: ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.light,
      darkTheme:
          ThemeData(primaryColor: Colors.red, brightness: Brightness.dark),
      routes: {
        'LaunchScreen': (context) => const LaunchScreen(),
        'HomeScreen': (context) => const HomeScreen(),
        'OutBoardingScreen': (context) => const OutBoardingScreen(),
        'BottomNavigationScreen': (context) => const BottomNavigationScreen(),
      },
    );
  }
}
