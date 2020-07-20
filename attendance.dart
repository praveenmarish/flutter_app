import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dbref.dart';

// ignore: must_be_immutable
class Attendance extends StatefulWidget {
  String yer,dep;
  bool isdelete;
  Attendance(this.yer,this.dep,this.isdelete);

  @override
  _AttendanceState createState() => _AttendanceState(yer,dep);
}

class _AttendanceState extends State<Attendance> {
   String cls,yer,dep;
  _AttendanceState(this.yer,this.dep);
  List<Condents> classes=List();
  List<Item> item=List();
  Dbref obj=new Dbref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference clsref=obj.getdetailref2(yer,dep);
    clsref.snapshots().listen((event) {
      setState(() {
        for (int i=0; i<event.documents.length;i++){
          classes.add(Condents.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void clearDatas(){
    setState(() {
      item.clear();
    });
  }

  void getstudent(String cls){
    clearDatas();
    CollectionReference ref=obj.getprofile(cls, yer, dep);
    ref.snapshots().listen((event) {
      setState(() {
        for (int i=0; i<event.documents.length;i++){
          item.add(Item.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void _addattendance(String cls){
    CollectionReference ref1=obj.placeattendance(cls,yer,dep);
    for (int i=0;i<item.length;i++){
      ref1.add(
          {
            'name':item[i].name,
            'attendance':item[i].isSelected?'present':'absent'
          }
      );
    }
  }


   void _delete(String cls){
     CollectionReference ref1=obj.placeattendance(cls,yer,dep);
     for (int i=0;i<item.length;i++){
       if (item[i].isSelected){
         ref1.document(item[i].key).delete();
       }
     }
   }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Selections'),
      ),
      body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new DropdownButton(
                hint: Text('select class'),
                onChanged: (name){
                  setState(() {
                    cls=name;
                    getstudent(cls);
                  });
                },
                value: cls,
                items: classes.map((e) => DropdownMenuItem(
                  child: Text(e.name),
                  value: e.name,
                )).toList(),
              ),

              new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount: item.length,
                  itemBuilder: (context,int index)=>Container(
                      color: item[index].isSelected
                          ?Colors.lightBlueAccent:Colors.white,
                      child: ListTile(
                        title: new Text(item[index].name),
                        subtitle: Text(item[index].age.toString()),
                        onTap: (){
                          setState(() {
                            item[index].isSelected=false;
                          });
                        },
                        onLongPress: (){
                          setState(() {
                            item[index].isSelected=true;
                          });
                        },
                      )
                  )
              ),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.lightBlueAccent,
                onPressed: (){
                  if(widget.isdelete){
                    _delete(cls);
                  }
                  else{
                    _addattendance(cls);
                  }
                },
              )
            ],
          ),
        ),
    );
  }
}
