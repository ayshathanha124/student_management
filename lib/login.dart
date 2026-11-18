import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_mngmnt/add.dart';
import 'package:student_mngmnt/details.dart';

class Loginpage extends StatefulWidget {
  const new({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  late Box studentBox;
  @override
  void initState(){
    super.initState();
    studentBox = Hive.box('students');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.settings),
                    ),
                  )
                ],
              ),
              Text('Students details',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
            SizedBox(height: 30,),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentBox.listenable(),
                 builder: (context, box, child) {
                  final students = box.values.toList();
                  final studentkeys = box.keys.toList();

                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index){
                      final student = students[index];
                      final studentkey = studentkeys[index];

                      return Card(
                        margin: EdgeInsets.all(8),
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(Icons.person),),
                          title: Text(student['name'].toString()),
                          subtitle: Text(
                            "age: ${student["age"]} | class: ${student["class"]}",
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>Detailspage(
                            student: student,
                            studentkey: studentkey,
                            ) ));
                          },
                        ),
                      );
                    });

                 })
                 ),
                 FloatingActionButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Addpage()));
                 },
                 child: Icon(Icons.add),
                 )
            ],
          ),
          ),
          ),
    );
  }
}