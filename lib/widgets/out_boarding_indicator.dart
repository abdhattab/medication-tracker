import 'package:flutter/cupertino.dart';

class OutBoardingIndicator extends StatelessWidget {
  final double marginEnd;
  final bool selected;

   const OutBoardingIndicator({this.marginEnd=0 ,required this.selected});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginEnd),
      width: 18,
      height: 4,
      decoration: BoxDecoration(
        color: selected ? const Color(0xff5800FF) :const Color(0xff72FFFF),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }


}