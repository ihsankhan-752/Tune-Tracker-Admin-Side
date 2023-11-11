import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AuthTextInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;

  const AuthTextInput({Key? key, required this.hintText, this.obscureText = false, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: TextStyle(
          color: AppColors.primaryWhite,
        ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.primaryWhite,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 10, top: 5),
        ),
      ),
    );
  }
}

class SearchTextInput extends StatefulWidget {
  final TextEditingController? searchController;
  final Function(String)? onChanged;
  const SearchTextInput({
    Key? key,
    this.searchController,
    this.onChanged,
  }) : super(key: key);

  @override
  State<SearchTextInput> createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<SearchTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: widget.searchController,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'search',
          suffixIcon: Icon(Icons.search, color: AppColors.primaryBlack),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}
