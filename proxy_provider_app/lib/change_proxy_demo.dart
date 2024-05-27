import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login with ChangeNotifier {
  String username;
  String password;

  Login({required this.username, required this.password});

  void changePassword(String password) {
    this.password = password;
    notifyListeners();
  }
}

class Employee with ChangeNotifier {
  final int empId;
  final String empName;
  final String username;
  final String password;

  Employee({
    required this.empId,
    required this.empName,
    required this.username,
    required this.password,
  });
}

class ChangeProxyDemo extends StatelessWidget {
  const ChangeProxyDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return Login(
              username: "aditya@1234",
              password: "aditya#0101",
            );
          },
        ),
        ChangeNotifierProxyProvider<Login, Employee>(
          create: (context) {
            return Employee(
                empId: 11,
                empName: "Aditya",
                username: Provider.of<Login>(context).username,
                password: Provider.of<Login>(context).password);
          },
          update: (context, login, employee) {
            return Employee(
                empId: 11,
                empName: "empName",
                username: "username",
                password: "password");
          },
        ),
      ],
    );
  }
}

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State createState() => _UIstate();
}

class _UIstate extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Proxy Provider"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
