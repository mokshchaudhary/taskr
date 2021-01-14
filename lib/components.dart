import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
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
      height: height * 0.1,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(width: 3),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              'Tasks',
              style: GoogleFonts.montserratAlternates(
                  textStyle: TextStyle(
                fontSize: 38,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 28,
            backgroundImage: FirebaseAuth.instance.currentUser.photoURL != null
                ? NetworkImage(FirebaseAuth.instance.currentUser.photoURL)
                : AssetImage('assets/icon.png'),
          ),
        ],
      ),
    );
  }
}

// Middle Body -----------------------------------------------------------------
class EmptyBody extends StatelessWidget {
  const EmptyBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
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
    return Container();
  }
}

// Button Shell ----------------------------------------------------------------
class StyleButton extends StatefulWidget {
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
  _StyleButtonState createState() => _StyleButtonState();
}

class _StyleButtonState extends State<StyleButton> {
  double x = 3;
  double y = 3;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (down) {
        setState(() {
          x = 1;
          y = 1;
        });
      },
      onTapUp: (up) {
        setState(() {
          x = 3;
          y = 3;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                x, // Move to right 10  horizontally
                y, // Move to bottom 10 Vertically
              ),
            ),
          ],
          border: Border.all(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        width: widget.width,
        height: widget.height,
        child: widget.child,
      ),
    );
  }
}

class Taskpill extends StatelessWidget {
  const Taskpill({
    Key key,
    @required this.height,
    @required this.width,
    @required this.text,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 3),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: height * 0.08,
        width: width * 0.9,
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
