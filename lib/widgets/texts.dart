import 'package:flutter/material.dart';

Widget regularText(String txt, {Color color = Colors.black, double size = 12, int? maxLines}) {
  return Text(
    txt,
    maxLines: maxLines,
    overflow: TextOverflow.fade,
    style: TextStyle(
      color: color,
      fontSize: size,
    ),
  );
}

Widget semiBoldText(String txt, { double size = 12, TextAlign align  = TextAlign.justify, Color color = Colors.black}){
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}

Widget boldText(String txt, { double size = 12, TextAlign align  = TextAlign.start, Color color = Colors.black}){
  return Text(
    txt,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );
}
