import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Secondpage());
}

class Item {
  String name;
  int age;
  bool isSelected=false;

  Item(this.name,this.age);

  Item.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data['name'],
        age=snapshot.data['age'];
}

class Secondpage extends StatefulWidget {
  @override
  _SecondpageState createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  List<Item> item=List();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection('admin/student/cse/first/l1').snapshots().listen((event) {
      setState(() {
        for (int i=0; i<event.documents.length;i++){
          item.add(Item.fromSnapshot(event.documents[i]));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Center(
        child:new SingleChildScrollView(
          child: Column(
            children: <Widget>[
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

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


