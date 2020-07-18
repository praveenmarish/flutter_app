import 'package:cloud_firestore/cloud_firestore.dart';

class Condents{
  String name;
  String key;
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

}