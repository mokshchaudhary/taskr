import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TOP BAR ---------------------------------------------------------------------
class Topbar extends StatelessWidget {
  const Topbar({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: height * 0.1,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tasks',
            style: GoogleFonts.montserratAlternates(
                textStyle: TextStyle(
              fontSize: 44,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: width * 0.3,
            height: height * 0.05,
            child: Center(
              child: Text('6 Jan',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

// Middle Body -----------------------------------------------------------------
class MiddleBody extends StatelessWidget {
  const MiddleBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/man.png')),
          Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            '  No Tasks',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          )
        ],
      ),
    ));
  }
}

// BOTTOM BAR ---------------------------------------------------------------------
class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      height: height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StyleButton(
              width: width * 0.2, height: height * 0.07, child: Icon(Icons.settings, size: 35)),
          StyleButton(
              width: width * 0.7,
              height: height * 0.07,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        decoration:
                            InputDecoration(border: InputBorder.none, hintText: 'Write A New Task'),
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black)),
                      ),
                    ),
                    Icon(
                      Icons.add,
                      size: 35,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

// Button Shell ----------------------------------------------------------------
class StyleButton extends StatelessWidget {
  const StyleButton({
    Key key,
    @required this.width,
    @required this.height,
    @required this.child,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(
              3, // Move to right 10  horizontally
              3, // Move to bottom 10 Vertically
            ),
          ),
        ],
        border: Border(
          top: BorderSide(width: 3.0, color: Colors.black),
          left: BorderSide(width: 3.0, color: Colors.black),
          right: BorderSide(width: 3.0, color: Colors.black),
          bottom: BorderSide(width: 3.0, color: Colors.black),
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
