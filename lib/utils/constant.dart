import 'package:flutter/material.dart';

double getHeight(BuildContext context,double height){
  return MediaQuery.of(context).size.height * height;
}double getWidth(BuildContext context,double width){
  return MediaQuery.of(context).size.width * width;}
