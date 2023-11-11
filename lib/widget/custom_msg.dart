import 'package:flutter/material.dart';

showCustomMsg(BuildContext context, String msg) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg)),
  );
}
