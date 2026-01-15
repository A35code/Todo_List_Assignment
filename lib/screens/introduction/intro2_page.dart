import 'package:flutter/material.dart';
import 'package:todo_list_assignment/screens/introduction/intro3_page.dart';
import 'package:todo_list_assignment/screens/task_page.dart';


class IntroPage2 extends StatefulWidget{
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage2();
}

class _IntroPage2 extends State<IntroPage2> {
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
                  'assets/images/forget.png',
                  width: 270,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  "Schedule current and future events to prevent you from forgetting later on.",
                  style: TextStyle(
                    fontSize: 25,
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
                        context, MaterialPageRoute(builder: (context) => IntroPage3()),);
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

