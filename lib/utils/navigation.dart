import 'package:flutter/material.dart';

 navigateToPage(BuildContext context,page){
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}