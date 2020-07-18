import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dbref.dart';

class Dialogshow {

  Dbref obj=new Dbref();
  String yer,dep,cls;


  List<Condents> getdep(){
    List<Condents> department=List();
    CollectionReference depref=obj.getdetailref('department');
    depref.snapshots().listen((event) {
      for (int i=0; i<event.documents.length;i++){
        department.add(Condents.fromSnapshot(event.documents[i]));
      }
    });
    return department;
  }

  List<Condents> getyear(){
    List<Condents> year=List();
    CollectionReference yerref=obj.getdetailref('year');
    yerref.snapshots().listen((event) {
      for (int i=0; i<event.documents.length;i++){
        year.add(Condents.fromSnapshot(event.documents[i]));
      }
    });
    return year;
  }

  shower(BuildContext context){
    List<Condents> year=getyear();
    List<Condents> department=getdep();
    return showDialog(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          title: Text('AlertDialog Title'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Container(
                height: 145,
                child: Column(
                  children: <Widget>[
                    DropdownButton(
                      hint: Text('select year'),
                      onChanged: (name){
                        setState(() {
                          yer=name;
                          print(yer);
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
                          print(dep);
                        });
                      },
                      value: dep,
                      items: department.map((e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e.name,
                      )).toList(),
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text('ok'),
                            onPressed: (){
                              setState((){
                              });
                            },
                          ),
                          FlatButton(
                            child: Text('Refresh'),
                            onPressed: (){
                              setState((){
                              });
                            },
                          ),
                          FlatButton(
                            child: Text('cancel'),
                            onPressed: (){
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      ),
                    ),

                    ],
                ),
              );
            },
          ),

        );
      },
    );
  }
}
