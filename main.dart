import 'package:flutter/material.dart';
import 'details.dart';
import 'addclass.dart';
import 'test.dart';
import 'deleteclass.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Add class',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Details(false,false,true)));
              },
            ),

            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Add student',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Details(false,true,false)));
              },
            ),

            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Attendance',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Details(true,false,false)));
                });
              },
            ),


            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Add year',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Addclass('year',null)));
                });
              },
            ),

            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Add dep',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Addclass(null,'department')));
                });
              },
            ),

            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'Add',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                Dialogshow().shower(context);
              },
            ),

            FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                'delete',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    Deleteclass()));
              },
            ),

          ],
        ),
      ),
    );
  }
}
