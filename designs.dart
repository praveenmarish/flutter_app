import 'Operations.dart';
import 'package:flutter/material.dart';
import 'AddDetails.dart';
import 'GetDetails.dart';

// ignore: must_be_immutable
class CustomView extends StatefulWidget {
  String text;
  CustomView(this.text);

  @override
  _CustomViewState createState() => _CustomViewState();
}

class _CustomViewState extends State<CustomView> {
  bool k = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))),
        child: Column(
          children: <Widget>[
            InkWell(
              splashColor: Colors.cyanAccent,
              onTap: () {
                if (widget.text == 'Add class') {
                  setState(() {
                    k = !k;
                  });
                } else if (widget.text == 'Add student') {
                  setState(() {
                    k = !k;
                  });
                } else if (widget.text == 'Attendance') {
                  setState(() {
                    k = !k;
                  });
                } else if (widget.text == 'Add year') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddDetails('year', null)));
                } else if (widget.text == 'Add dep') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddDetails(null, 'department')));
                } else if (widget.text == 'Delete students') {
                  setState(() {
                    k = !k;
                  });
                } else if (widget.text == 'Delete class') {
                  setState(() {
                    k = !k;
                  });
                } else if (widget.text == 'Delete department') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Attendance(null, null, widget.text)));
                } else if (widget.text == 'Delete year') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Attendance(null, null, widget.text)));
                }
              },
              child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        widget.text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            k ? GetDetails(widget.text) : new Container(),
          ],
        ),
      ),
    );
  }
}
