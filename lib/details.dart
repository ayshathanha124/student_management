import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_mngmnt/add.dart';
import 'package:student_mngmnt/login.dart';

class Detailspage extends StatefulWidget {
  final dynamic student;
  final dynamic studentkey;

  Detailspage({super.key, required this.student, required this.studentkey});

  @override
  State<Detailspage> createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  late Map<String, dynamic> student;
  @override
  void initState(){
    super.initState();
    student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,

        ),
        ),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage()));
        },
         icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person, size: 50,),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "${widget.student['name']}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),
            Card(
              child: ListTile(
                leading: Icon(Icons.cake_sharp),
                title: Text('Age'),
                subtitle: Text("${widget.student['age']}"),
              ) ,
            ),
                Card(
              child: ListTile(
                leading: Icon(Icons.school_outlined),
                title: Text('class'),
                subtitle: Text("${widget.student['class']}"),
              ) ,
            ),
                Card(
              child: ListTile(
                leading: Icon(Icons.bloodtype_outlined),
                title: Text('blood group'),
                subtitle: Text("${widget.student['blood group']}"),
              ) ,
            ),
                Card(
              child: ListTile(
                leading: Icon(Icons.maps_home_work_outlined),
                title: Text('address'),
                subtitle: Text("${widget.student['address']}"),
              ) ,
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              await Navigator.push(context, MaterialPageRoute(builder: (context) => Addpage(
                student: widget.student,
                studentkey: widget.studentkey,
              ),
              ),
              );
              final Box = Hive.box('students');
              final updatedstudent = Box.get(widget.studentkey);
              if (updatedstudent != null){
                setState(() {
                   student=updatedstudent;
                });
              }
            },
             child: Text('edit'),
             ),
             SizedBox(height: 10,),
             ElevatedButton(onPressed: ()async{
              final confirm = await showDialog<bool>(
                context: context, builder:(context){
                  return AlertDialog(
                    title: Text('confirm delete'),
                    content: Text('r u sure u  wnt to dlte',),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop(false);
                      },
                       child: Text('Delete'),
                       ),
                    ],
                  );
                }
                );
                if (confirm == true){
                  final box = Hive.box('students');
                  await box.delete(widget.studentkey);
                  if(mounted){
                    Navigator.pop(context);
                  }
                }
             },
             style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
             ),
              child: Text('Delete',),
              ),
          ],
        ),
        ),
      ),
    );
  }
}