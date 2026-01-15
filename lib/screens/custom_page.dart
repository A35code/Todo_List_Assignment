import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_assignment/models/task.dart';
import 'package:intl/intl.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPage();
}

class _CustomPage extends State<CustomPage> {
  final TextEditingController _todoController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Box? _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box('tasks');
  }

  // 📅 Date picker
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // ⏰ Time picker
  Future<void> _pickTime() async {
    TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: _selectedTime);

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveTodo() {
    if (_todoController.text.trim().isEmpty) return;

    DateTime finalDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    Task task = Task(
      todo: _todoController.text.trim(),
      timeStamp: finalDateTime,
      done: false,
    );

    _box!.add(task.toMap());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Schedule Activity",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _todoController,
              decoration: const InputDecoration(
                labelText: "Todo",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.amber),
              title: const Text("Select Date",
                style: TextStyle(color: Colors.amber)
              ),
              subtitle: Text(
                DateFormat('EEEE, d MMMM').format(_selectedDate),
                style: const TextStyle(
                  color: Colors.lightBlue, // change to whatever color you like
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: _pickDate,
            ),

            // Time picker
            ListTile(
              leading: const Icon(Icons.access_time, color: Colors.amber,),
              title: const Text("Select Time",
              style: TextStyle(color: Colors.amber)
              ),
              subtitle: Text(_selectedTime.format(context),
                style: const TextStyle(
                  color: Colors.lightBlue, // change to whatever color you like
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: _pickTime,
            ),

            const Spacer(),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTodo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                ),
                child: const Text("Save Todo",),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
