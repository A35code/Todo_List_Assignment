import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_assignment/models/task.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_assignment/screens/custom_page.dart';



class TaskPage extends StatefulWidget{
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  double? _deviceHeight, _deviceWidth;
  String? content;
  Box? _box;

  void _showEditDateTimeDialog(int index, Task task) async {
    DateTime selectedDate = task.timeStamp;
    TimeOfDay selectedTime =
    TimeOfDay(hour: task.timeStamp.hour, minute: task.timeStamp.minute);

    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.isBefore(now) ? now : selectedDate,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    // Pick time
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime == null) return;

    DateTime updatedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    task.timeStamp = updatedDateTime;
    _box!.putAt(index, task.toMap());
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: _deviceHeight! * 0.1,
        backgroundColor: Colors.amber,
        title: const Text(
          "Events Planned",
          style: TextStyle(fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomPage()),
              ).then((_) => setState(() {}));
            },
            icon: const Icon(Icons.schedule, color: Colors.grey),
            label: const Text(
              "Schedule",
              style: TextStyle(color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

      body: _taskWidget(),
      floatingActionButton: FloatingActionButton(
          onPressed: displayTaskPop,
        backgroundColor: Colors.amber,
        child: Icon(Icons.add,),
      ),
    );
  }

  Widget _todolist(){

    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index){
          var task = Task.fromMap(tasks[index]);
          return ListTile(
            leading: Checkbox(
              value: task.done,
              onChanged: (value) {
                task.done = value!;
                _box!.putAt(index, task.toMap());
                setState(() {});
              },
            ),
            title: Text(
              task.todo,
              style: TextStyle(
                color: task.done ? Colors.amber : Colors.amber,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(formatDate(task.timeStamp),
              style: const TextStyle(
                color: Colors.lightBlue,
                fontSize: 13,
              ),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit_text') {
                  _showEditDialog(index, task);
                } else if (value == 'edit_datetime') {
                  _showEditDateTimeDialog(index, task);
                } else if (value == 'delete') {
                  _showDeleteDialog(index);
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'edit_text',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 18),
                      SizedBox(width: 8),
                      Text('Edit todo'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit_datetime',
                  child: Row(
                    children: [
                      Icon(Icons.schedule, size: 18),
                      SizedBox(width: 8),
                      Text('Edit date & time'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 18, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),

          );
        });
  }
  Widget _taskWidget(){
    return FutureBuilder(future: Hive.openBox("tasks"),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            _box = snapshot.data;
            return _todolist();
          }else{
            return Center(child: const CircularProgressIndicator());
          }
        });
  }
  
  void displayTaskPop(){
    showDialog(context: context, builder:(BuildContext _context){
      return AlertDialog(
        title: const Text("Add a todo"),
        content: TextField(
          onSubmitted: (value){
            if(content != null){
              var task = Task(todo: content!, timeStamp: DateTime.now(), done: false);
              _box!.add(task.toMap());

              setState(() {
                print(value);
                Navigator.pop(context);
              });
            }
          },
          onChanged: (value){
            setState(() {
              content = value;
              print(value);
            });
          },
        ),
      );
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Todo"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _box!.deleteAt(index);
                Navigator.pop(context); // Close dialog
                setState(() {});
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(int index, Task task) {
    TextEditingController controller =
    TextEditingController(text: task.todo);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Todo"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Update your todo",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cancel
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  task.todo = controller.text.trim();
                  _box!.putAt(index, task.toMap());
                  setState(() {});
                }
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  String formatDate(DateTime dateTime) {
    String dayName = DateFormat('EEEE').format(dateTime); // Tuesday
    String day = DateFormat('d').format(dateTime);        // 14
    String month = DateFormat('MMMM').format(dateTime);   // February
    String time = DateFormat('jm').format(dateTime);      // 10:45 AM

    String suffix = 'th';
    int dayNum = int.parse(day);

    if (dayNum % 10 == 1 && dayNum != 11) {
      suffix = 'st';
    } else if (dayNum % 10 == 2 && dayNum != 12) {
      suffix = 'nd';
    } else if (dayNum % 10 == 3 && dayNum != 13) {
      suffix = 'rd';
    }

    return '$dayName, $day$suffix $month · $time';
  }
}