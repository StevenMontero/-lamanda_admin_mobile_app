import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget titlePage(BuildContext context) {
  return AppBar(
    leading: SafeArea(
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
    centerTitle: true,
    title: SafeArea(
      child: Container(
        height: 70,
        width: 70,
        child: SvgPicture.asset(
          'assets/img/Logo_COLOR.svg',
          fit: BoxFit.scaleDown,
        ),
      ),
    ),
  );
}