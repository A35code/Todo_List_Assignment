import 'package:flutter/material.dart';
import 'package:todo_list_assignment/screens/task_page.dart';
import 'package:todo_list_assignment/screens/introduction/intro2_page.dart';

class IntroPage extends StatefulWidget{
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),

              Center(
                child: Image.asset(
                  'assets/images/todo.jpeg',
                  width: 240,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  "Event Planner",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ) ,

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  "Your No. 1 Scheduling Assistant.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ) ,

              const SizedBox(height: 210,),

              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => TaskPage()),);
                    },
                    child: Text(">>> Skip",
                    style: TextStyle(
                    color: Colors.lightBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(width: 210),

                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => IntroPage2()),);
                    },
                    child: Text("Next",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

