import 'package:flutter/material.dart';
import 'package:todo_list_assignment/screens/task_page.dart';


class IntroPage3 extends StatefulWidget{
  const IntroPage3({super.key});

  @override
  State<IntroPage3> createState() => _IntroPage3();
}

class _IntroPage3 extends State<IntroPage3> {
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
                  'assets/images/ready.jpeg',
                  width: 270,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  "You are now ready to plan your daily events",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ) ,

              const SizedBox(height: 15),

              const Center(
                child: Text(
                  "Have fun and wish you all the best.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ) ,

              const SizedBox(height: 190,),

              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => TaskPage()),);
                    },
                    child: Text("Next",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

