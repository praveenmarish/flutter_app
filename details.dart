import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'attendance.dart';
import 'addstd.dart';
import 'dbref.dart';
import 'addclass.dart';
import 'deleteclass.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String text;
  Details(this.text);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  List<Condents> year = List();
  List<Condents> department = List();
  String yer, dep, cls;
  Dbref obj = new Dbref();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference yearref = obj.getdetailref('year');
    CollectionReference depref = obj.getdetailref('department');
    yearref.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          year.add(Condents.fromSnapshot(event.documents[i]));
        }
      });
    });
    depref.snapshots().listen((event) {
      setState(() {
        for (int i = 0; i < event.documents.length; i++) {
          department.add(Condents.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: <Widget>[
          DropdownButton(
            hint: Text('select year'),
            onChanged: (name) {
              setState(() {
                yer = name;
              });
            },
            value: yer,
            items: year
                .map((e) =>
                DropdownMenuItem(
                  child: Text(e.name),
                  value: e.name,
                ))
                .toList(),
          ),
          DropdownButton(
            hint: Text('select department'),
            onChanged: (name) {
              setState(() {
                dep = name;
              });
            },
            value: dep,
            items: department
                .map((e) =>
                DropdownMenuItem(
                  child: Text(e.name),
                  value: e.name,
                ))
                .toList(),
          ),
          FlatButton(
            color: Colors.black,
            textColor: Colors.white,
            child: Text(
              'Enter',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              if (widget.text=='Attendance') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Attendance(yer, dep, false)));
              } else if (widget.text=='Add student') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Addstudent(yer, dep)));
              } else if (widget.text=='Add class') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Addclass(yer, dep)));
              } else if (widget.text=='Delete students') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Attendance(yer, dep, true)));
              } else if (widget.text=='Delete class') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Deleteclass(yer, dep)));
              }
            },
          )
        ],
      ),
    );
  }
}