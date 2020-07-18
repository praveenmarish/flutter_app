import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dbref.dart';


// ignore: must_be_immutable
class Addclass extends StatefulWidget {
  String yer,dep;
  Addclass(this.yer,this.dep);

  @override
  _AddclassState createState() => _AddclassState();
}

class _AddclassState extends State<Addclass> {

  List<Condents> classes=[];
  TextEditingController eCtrl = new TextEditingController();
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getclass();
  }

  void getclass(){
    cleardata();
    var yer=widget.yer;
    var dep=widget.dep;
    CollectionReference getref;
    if(yer!=null&&dep!=null){
     getref=Firestore.instance.collection('cl');
    }
    else if(yer==null&&dep!=null){
      getref=Firestore.instance.collection('cl');
    }
    else if(dep==null&&yer!=null){
      getref=Firestore.instance.collection('cl');
    }
    getref.snapshots().listen((event) {
      setState(() {
        for (int i=0; i<event.documents.length;i++){
          classes.add(Condents.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  void cleardata(){
    setState(() {
      classes.clear();
    });
  }

  void addclassname(String name) {
    String yer = widget.yer;
    String dep = widget.dep;
    CollectionReference addref;
    if(yer!=null&&dep!=null){
      addref=Firestore.instance.collection('cl');
    }
    else if(yer==null&&dep!=null){
      addref=Firestore.instance.collection('cl');
    }
    else if(dep==null&&yer!=null){
      addref=Firestore.instance.collection('cl');
    }
    addref.add(
        {
          'name': name,
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add class'),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                addclassname(text);
                eCtrl.clear();
                cleardata();
                setState(() {});
              },
            ),

            new ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                itemCount: classes.length,
                itemBuilder: (context,int index)=>Container(
                    child: ListTile(
                      title: new Text(classes[index].name.toString()),
                    )
                )
            ),

          ],
        ),
      )
    );
  }
}
