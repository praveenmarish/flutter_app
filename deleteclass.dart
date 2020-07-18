import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dbref.dart';

class Deleteclass extends StatefulWidget {
  @override
  _DeleteclassState createState() => _DeleteclassState();
}

class _DeleteclassState extends State<Deleteclass> {

  String cls,yer,dep;
  List<Condents> classes=List();
  List<Item> item=List();
  Dbref obj=new Dbref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CollectionReference clsref=Firestore.instance.collection('cl');
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
    CollectionReference ref=Firestore.instance.collection('collage/student/cse/2020/l1');
    ref.snapshots().listen((event) {
      setState(() {
        for (int i=0; i<event.documents.length;i++){
          item.add(Item.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void _delete(String cls){
    CollectionReference ref1=Firestore.instance.collection('collage/student/cse/2020/l1');
    for (int i=0;i<item.length;i++){
      if (item[i].isSelected){
        ref1.document(item[i].key).delete();
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
                _delete(cls);
              },
            )
          ],
        ),
      ),
    );
  }
}
