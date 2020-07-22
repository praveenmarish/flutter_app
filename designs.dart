import 'package:flutter/material.dart';
import 'addclass.dart';
import 'deleteclass.dart';
import 'details.dart';

class Customview extends StatefulWidget {
  String text;
  Customview(this.text);

  @override
  _CustomviewState createState() => _CustomviewState();
}

class _CustomviewState extends State<Customview> {

  bool k=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12))
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              splashColor: Colors.cyanAccent,
              onTap: (){
                if(widget.text=='Add class'){
                  setState(() {
                    k=!k;
                  });
                }
                else if(widget.text=='Add student'){
                  setState(() {
                    k=!k;
                  });
                }
                else if(widget.text=='Attendance'){
                  setState(() {
                    k=!k;
                  });
                }
                else if(widget.text=='Add year'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Addclass('year',null)));
                }
                else if(widget.text=='Add dep'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Addclass(null,'department')));
                }
                else if(widget.text=='Delete students'){
                  setState(() {
                    k=!k;
                  });
                }
                else if(widget.text=='Delete class'){
                  setState(() {
                    k=!k;
                  });
                }
                else if(widget.text=='Delete department'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Deleteclass(null,'department')));
                }
                else if(widget.text=='Delete year'){
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
                        widget.text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            k?Details(widget.text):new Container(),
          ],
        ),
      ),
    );
  }
}
