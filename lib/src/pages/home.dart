import 'package:flutter/material.dart';

import '../theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView(
        gridDelegate: null,
      ),
    );
  }
}
