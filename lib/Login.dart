import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(image: AssetImage('assets/pin.png'), height: 200),
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 50),
                child: Container(
                  height: height * 0.4,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(4, 4),
                      )
                    ],
                    color: Colors.white,
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(fontSize: 36),
                            fontWeight: FontWeight.w500,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 15),
                        child: GestureDetector(
                          onTap: () async {
                            AlertDialog alert = AlertDialog(
                              content: Container(
                                height: 90,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                                )),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                            await signInWithGoogle().then((value) =>
                                Navigator.of(context, rootNavigator: true).pop('dialog'));
                          },
                          child: StyleButton(
                              width: width * 0.7,
                              height: height * 0.08,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage('assets/google.png'),
                                    height: 25,
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                  Text(
                                    'Sign in with Google',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17, fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AlertDialog alert = AlertDialog(
                            title: Text("Coming Soon"),
                            content: Text("Please Login With Google Instead"),
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        onLongPress: () {
                          AlertDialog alert = AlertDialog(
                            content: Container(
                              height: 90,
                              child: Center(
                                  child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                              )),
                            ),
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: 'try123@123.com', password: '123456')
                              .then((value) {
                            Navigator.of(context, rootNavigator: true).pop('dialog');
                          }).catchError((error) {
                            debugPrint(error);
                          });
                        },
                        child: StyleButton(
                            width: width * 0.7,
                            height: height * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  size: 30,
                                ),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                                Text(
                                  'Email',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17, fontWeight: FontWeight.w500),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
