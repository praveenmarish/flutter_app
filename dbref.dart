import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'addclass.dart';
import 'deleteclass.dart';

class Condents{
  String name;
  String key;
  bool isSelected=false;
  Condents(this.name);
  Condents.fromSnapshot(DocumentSnapshot snapshot)
      :name=snapshot.data['name'],
       key=snapshot.documentID;
}

class Item {
  String name;
  int age;
  bool isSelected=false;
  String key;
  Item(this.name,this.age);
  Item.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data['name'],
        age=snapshot.data['age'],
        key=snapshot.documentID;
}


class Dbref{
  CollectionReference getprofile(String cls,String yer,String dep){
    return(Firestore.instance.collection('collage/student/$dep/$yer/$cls'));
  }

  CollectionReference placeattendance(String cls,String yer,String dep){
    var datetime = new DateTime.now().toString();
    var dateParse = DateTime.parse(datetime);
    var date = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var hour = "${dateParse.hour}";
    return(Firestore.instance.collection('$dep/$yer/$cls/$date/$hour'));
  }

  CollectionReference getdetailref(String val){
    return(Firestore.instance.collection('$val'));
  }

  CollectionReference getdetailref2(String year,String department){
    return(Firestore.instance.collection('class/$department/$year'));
  }

}

// ignore: must_be_immutable
class Customview extends StatelessWidget {
  
  String text;
  
  Customview(this.text);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))
        ),
        child: InkWell(
          splashColor: Colors.cyanAccent,
          onTap: (){
            if(text=='Add class'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Details(false,false,true,false,false)));
            }
            else if(text=='Add student'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Details(false,true,false,false,false)));
            }
            else if(text=='Attendance'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Details(true,false,false,false,false)));
            }
            else if(text=='Add year'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Addclass('year',null)));
            }
            else if(text=='Add dep'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Addclass(null,'department')));
            }
            else if(text=='Delete students'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Details(false,false,false,true,false)));
            }
            else if(text=='Delete class'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Details(false,false,false,false,true)));
            }
            else if(text=='Delete department'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Deleteclass(null,'department')));
            }
            else if(text=='Delete year'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Deleteclass('year',null)));
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
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
