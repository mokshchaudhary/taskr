import 'package:flutter/material.dart';
import 'package:taskr/components.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Topbar(height: height, width: width),
            ],
          ),
        ),
      ),
    );
  }
}
