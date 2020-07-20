import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'attendance.dart';
import 'addstd.dart';
import 'dbref.dart';
import 'addclass.dart';
import 'deleteclass.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  bool isattendance,isaddstudent,isaddclass,isdeletestudent,isdeleteclass;
  Details(this.isattendance,this.isaddstudent,this.isaddclass,this.isdeletestudent,this.isdeleteclass);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  List<Condents> year=List();
  List<Condents> department=List();
  String yer,dep,cls;
  Dbref obj=new Dbref();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      CollectionReference yearref=obj.getdetailref('year');
      CollectionReference depref=obj.getdetailref('department');
      yearref.snapshots().listen((event) {
        setState(() {
          for (int i=0; i<event.documents.length;i++){
            year.add(Condents.fromSnapshot(event.documents[i]));
          }
        });
      });
      depref.snapshots().listen((event) {
        setState(() {
          for (int i=0; i<event.documents.length;i++){
            department.add(Condents.fromSnapshot(event.documents[i]));
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select basic details'),
      ),
      body: Center(
        child:Container(
          color: Colors.black12,
          height: 200,
          child: Column(
           children: <Widget>[

            DropdownButton(
              hint: Text('select year'),
              onChanged: (name){
                setState(() {
                  yer=name;
                });
              },
              value: yer,
              items: year.map((e) => DropdownMenuItem(
                child: Text(e.name),
                value: e.name,
              )).toList(),
            ),

            DropdownButton(
              hint: Text('select department'),
              onChanged: (name){
                setState(() {
                  dep=name;
                });
              },
              value: dep,
              items: department.map((e) => DropdownMenuItem(
                child: Text(e.name),
                value: e.name,
              )).toList(),
            ),

            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Enter',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                if(widget.isattendance){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Attendance(yer,dep,false)));
                }
                else if(widget.isaddstudent){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Addstudent(yer,dep)));
                }
                else if(widget.isaddclass){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Addclass(yer,dep)));
                }
                else if(widget.isdeletestudent){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Attendance(yer,dep,true)));
                }
                else if(widget.isdeleteclass){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Deleteclass(yer,dep)));
                }
              },
            )
          ],
        ),
        ),
      ),
    );
  }
}
