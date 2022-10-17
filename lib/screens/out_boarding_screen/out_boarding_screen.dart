import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medication_tracker/preferences/shared_pref_controller.dart';
import 'package:medication_tracker/widgets/out_boarding_indicator.dart';

import '../../widgets/out_boarding_content.dart';

class OutBoardingScreen extends StatefulWidget {
  const OutBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OutBoardingScreen> createState() => _OutBoardingScreenState();
}

class _OutBoardingScreenState extends State<OutBoardingScreen> {
  int _currentPage = 0;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController=PageController();
  }
  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Visibility(
                visible: _currentPage != 2,
                replacement: TextButton( onPressed: () {
                  SharedPrefController().save();
                  Navigator.pushReplacementNamed(context, 'BottomNavigationScreen');
                },child: const Text('START'),),
                child: TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(2);
                  },
                  child: Text('SKIP',style:GoogleFonts.cabin(),),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                scrollDirection: Axis.horizontal,
                children: const [
                  OutBoardingWidget(
                    image: 'images/medical-checkup.png',
                    title: 'Medication Tracker',
                    content:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                  ),
                  OutBoardingWidget(
                    image: 'images/medical-report.png',
                    title: 'Scheduler your Medication',
                    content:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  ),
                  OutBoardingWidget(
                    image: 'images/medical-tools.png',
                    title: 'Looks Good !',
                    content:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 51),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutBoardingIndicator(
                    marginEnd: 14, selected: _currentPage == 0),
                OutBoardingIndicator(
                    marginEnd: 14, selected: _currentPage == 1),
                OutBoardingIndicator(
                    marginEnd: 14, selected: _currentPage == 2),
              ],
            ),
            const SizedBox(height: 39),
            Visibility(
              visible: _currentPage == 2,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              maintainSemantics: false,
              maintainInteractivity: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    SharedPrefController().save();
                    Navigator.pushReplacementNamed(context, 'BottomNavigationScreen');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 53), backgroundColor: const Color(0xff0096FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Text(
                    'START',
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 62),
          ],
        ),
      ),
    );
  }
}
