import 'package:flutter/material.dart';

/// for the use of log() method
import 'dart:developer';

import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EphemeralStateDemo(),
    );
  }
}

class EphemeralStateDemo extends StatefulWidget {
  const EphemeralStateDemo({super.key});

  @override
  State<EphemeralStateDemo> createState() => _SetStateManagement();
}

class _SetStateManagement extends State<EphemeralStateDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade400,
        centerTitle: true,
        title: const Text(
          "SetState Management Demo",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Course(
            courseName: "Java",
          ),
          SizedBox(
            height: 50,
          ),
          Course(
            courseName: "Flutter",
          ),
        ],
      ),
    );
  }
}

class Course extends StatefulWidget {
  final String courseName;
  const Course({super.key, required this.courseName});

  @override
  State createState() => _CourseState();
}

class _CourseState extends State<Course> {
  int courseCount = 0;
  @override
  Widget build(BuildContext context) {
    /// avoid print in production code use log() method.
    log("In CourseState build");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              courseCount++;
            });
          },
          child: Container(
            height: 80,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.orange.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(widget.courseName),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Container(
          height: 80,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("Count : $courseCount"),
        ),
      ],
    );
  }
}
