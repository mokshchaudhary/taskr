import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Topbar(height: height, width: width),
                  MiddleBody(height: height, width: width),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiddleBody extends StatefulWidget {
  final double height;
  final double width;

  const MiddleBody({
    Key key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _MiddleBodyState createState() => _MiddleBodyState();
}

class _MiddleBodyState extends State<MiddleBody> {
  List myList = ['null'];
  lol() async {
    List l = await getTask();
    setState(() {
      myList = l;
    });
  }

  @override
  void initState() {
    super.initState();
    lol();
  }

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: myList.isEmpty
              ? Center(child: EmptyBody())
              : Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 30),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      List l = await getTask();
                      setState(() {
                        myList = l;
                      });
                    },
                    child: ListView.builder(
                      itemCount: myList.length,
                      itemBuilder: (context, index) {
                        if (myList[0] == 'null') {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              setState(() {
                                myList.removeAt(index);
                              });
                              setdata(myList);
                            },
                            child: Taskpill(
                                height: widget.height, width: widget.width, text: myList[index]),
                          );
                        }
                      },
                    ),
                  ),
                ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 0),
          height: widget.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _settingpanel(context);
                },
                child: StyleButton(
                    width: widget.width * 0.2,
                    height: widget.height * 0.07,
                    child: Icon(Icons.settings, size: 35)),
              ),
              StyleButton(
                  width: widget.width * 0.7,
                  height: widget.height * 0.07,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              onSubmitted: (text) {
                                setState(() {
                                  if (_controller.text != '') {
                                    myList.add(_controller.text);
                                    setdata(myList);
                                    _controller.clear();
                                  }
                                });
                              },
                              autocorrect: false,
                              controller: _controller,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Write A New Task'),
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_controller.text != '') {
                                  myList.add(_controller.text);
                                  setdata(myList);
                                  _controller.clear();
                                }
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 40,
                              child: Icon(
                                Icons.add,
                                size: 35,
                              ),
                            ),
                          )
                        ],
                      )))
            ],
          ),
        )
      ],
    ));
  }
}

void _settingpanel(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 3),
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    height: 60,
                    width: 500,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(width: 3),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        'Logout',
                        style: GoogleFonts.montserrat(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Future getTask() async {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference coll = FirebaseFirestore.instance.collection('users');
  List l = await coll.doc(firebaseUser.uid).get().then((value) {
    if (value.data() != null) {
      return value.data()['task'];
    } else {
      return [];
    }
  });
  return l;
}

void setdata(task) async {
  print(task);
  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference coll = FirebaseFirestore.instance.collection('users');
  await coll.doc(firebaseUser.uid).set({'task': task});
}
