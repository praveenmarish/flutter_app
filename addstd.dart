import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dbref.dart';

// ignore: must_be_immutable
class Addstudent extends StatefulWidget {
  String dep,yer;
  Addstudent(this.yer,this.dep);

  @override
  _AddstudentState createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {

  TextEditingController eCtrl = new TextEditingController();
  String name,age,cls;
  Dbref obj=new Dbref();
  List<Condents> classes=List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference clsref=obj.getdetailref2(widget.yer,widget.dep);
    clsref.snapshots().listen((event) {
      setState(() {
        for (int i=0; i<event.documents.length;i++){
          classes.add(Condents.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void save(String name, String age, String classname) {
    CollectionReference ref=obj.getprofile(classname, widget.yer, widget.dep);
    ref.add({
      'name':name,
      'age':age
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add student'),
      ),
      body: Center(
        child: Container(
          height: 200,
          child: Column(
            children: <Widget>[

              new Text('Name:'),
              new TextField(
                controller: eCtrl,
                onSubmitted: (value){
                  setState(() {
                    name=value;
                  });
                },
              ),

              new Text('age:'),
              new TextField(
                controller: eCtrl,
                onSubmitted: (value){
                  setState(() {
                    age=value;
                  });
                },
              ),

              new DropdownButton(
                hint: Text('select class'),
                onChanged: (name){
                  setState(() {
                    cls=name;
                  });
                },
                value: cls,
                items: classes.map((e) => DropdownMenuItem(
                  child: Text(e.name),
                  value: e.name,
                )).toList(),
              ),

              new FlatButton(
                child: Text('enter'),
                onPressed: (){
                  save(name,age,cls);
                  eCtrl.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
