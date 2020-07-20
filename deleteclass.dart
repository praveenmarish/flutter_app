import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dbref.dart';

class Deleteclass extends StatefulWidget {
  String department,year;
  Deleteclass(this.year,this.department);
  @override
  _DeleteclassState createState() => _DeleteclassState(year,department);
}

class _DeleteclassState extends State<Deleteclass> {

  String cls,yer,dep;
  _DeleteclassState(this.yer,this.dep);


  List<Condents> classes=List();
  CollectionReference clsref;
  Dbref obj=new Dbref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(yer!=null&&dep!=null){
      setState(() {
        clsref=obj.getdetailref2(yer, dep);
      });
    }
    else if(yer==null&&dep!=null){
      setState(() {
        clsref=obj.getdetailref(dep);
      });
    }
    else if(yer!=null&&dep==null){
      setState(() {
        clsref=obj.getdetailref(yer);
      });
    }

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
      classes.clear();
    });
  }

  void _delete(String cls){
    for (int i=0;i<classes.length;i++){
      if (classes[i].isSelected){
        clsref.document(classes[i].key).delete();
      }
    }
    clearDatas();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('delete'),
      ),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[

            new ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                itemCount: classes.length,
                itemBuilder: (context,int index)=>Container(
                    color: classes[index].isSelected
                        ?Colors.lightBlueAccent:Colors.white,
                    child: ListTile(
                      title: new Text(classes[index].name),
                      onTap: (){
                        setState(() {
                          classes[index].isSelected=false;
                        });
                      },
                      onLongPress: (){
                        setState(() {
                          classes[index].isSelected=true;
                        });
                      },
                    )
                )
            ),
            RaisedButton(
              child: Text('Submit'),
              color: Colors.lightBlueAccent,
              onPressed: (){
                _delete(cls);
              },
            )
          ],
        ),
      ),
    );
  }
}
