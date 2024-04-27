// provider state management example

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) {
        return Company(companyName: "Google", empCount: 250);
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MainAppState();
}

class _MainAppState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text("Provider State Management Demo"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Provider.of<Company>(context).companyName),
              const SizedBox(width: 30),
              Text("${Provider.of<Company>(context).empCount}"),
            ],
          ),
        ],
      ),
    );
  }
}

class Company {
  String companyName;
  int empCount;

  Company({required this.companyName, required this.empCount});
}
