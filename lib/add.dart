
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Addpage extends StatefulWidget {
  final dynamic student;
  final dynamic studentkey;
  const new({super.key, this.student, this.studentkey});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  @override
  void initState() {
    super.initState();
    if(widget.student != null){
      namecontroller.text = widget.student!['name'];
      agecontroller.text = widget.student!['age'].toString();
      classcontroller.text = widget.student!['class'].toString();
      bloodgroupcontroller.text =widget.student!['blood group'].toString();
      addresscontroller.text =widget.student!['address']?.toString() ?? '';

    }
  }
  final namecontroller =TextEditingController();
  final agecontroller =TextEditingController();
  final classcontroller =TextEditingController();
  final bloodgroupcontroller =TextEditingController();
  final addresscontroller =TextEditingController();

  @override
  void dispose() {
    namecontroller.dispose();
    agecontroller.dispose();
    classcontroller.dispose();
    bloodgroupcontroller.dispose();
    addresscontroller.dispose();

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person,color: Colors.white,),
                  ),
                  SizedBox(height: 20,),
                  TextButton(onPressed: (){}, child: Text("Add image",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  ),
                  SizedBox(height: 20,),
                  Text('name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(height: 20,),
                  Text('Age',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  TextField(
                    controller: agecontroller,
                    decoration: InputDecoration(
                      hintText: "Enter your age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(height: 20,),
                  Text('Class',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  TextField(
                    controller: classcontroller,
                    decoration: InputDecoration(
                      hintText: "Enter your class",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(height: 20,),
                  Text('blood group',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  TextField(
                    controller: bloodgroupcontroller,
                    decoration: InputDecoration(
                      hintText: "Enter your blood group",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(height: 20,),
                  Text('Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
          
                  TextField(
                    controller: addresscontroller,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter your address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () async {
                        Map<String, dynamic> student = {
                          "name": namecontroller.text.trim(),
                          "age":int.tryParse(agecontroller.text.trim())??
                          0,
                          "class":int.tryParse(classcontroller.text.trim()),
                          "blood group":int.tryParse(bloodgroupcontroller.text.trim()),
                          "address":int.tryParse(addresscontroller.text.trim()),
                        };
                        final box = Hive.box('students');

                        if(widget.studentkey != null){
                          await box.put(widget.studentkey, student);
                        }else{
                          await box.add(student);
                        }
                        if(mounted){
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        foregroundColor: Colors.amber,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        )
                        ),
                       child: Text('move student'),
                       ),
                    ],
                  )
                ],
              ),
            ),
            )
          ),
      ),
    );
  }
}