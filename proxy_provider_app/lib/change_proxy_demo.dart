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
              username: Provider.of<Login>(context, listen: false).username,
              password: Provider.of<Login>(context, listen: false).password,
            );
          },
          update: (context, login, employee) {
            return Employee(
              empId: 11,
              empName: "Aditya",
              username: login.username,
              password: login.password,
            );
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UI_Proxy(),
      ),
    );
  }
}

// ignore: camel_case_types
class UI_Proxy extends StatefulWidget {
  const UI_Proxy({super.key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Provider.of<Employee>(context).empId}"),
            const SizedBox(height: 20),
            Text(Provider.of<Employee>(context).empName),
            const SizedBox(height: 20),
            Text(Provider.of<Login>(context).username),
            const SizedBox(height: 20),
            Consumer<Login>(
              builder: (context, login, child) {
                return Text(login.password);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<Login>(context, listen: false)
                    .changePassword("aditya@2000");
              },
              child: const Text("Change Password"),
            ),
          ],
        ),
      ),
    );
  }
}
