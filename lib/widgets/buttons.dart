import 'package:ecommerce_admin_panel/widgets/texts.dart';
import 'package:flutter/material.dart';

Widget mainButton(String label, {required Function() onPressed}) {
  return MaterialButton(
    onPressed: onPressed,
    color: Colors.blue.shade800,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: regularText(label, color: Colors.white),
  );
}

Widget textButton(String label, {required Function() onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: regularText(label, color: Colors.blue.shade800),
  );
}
