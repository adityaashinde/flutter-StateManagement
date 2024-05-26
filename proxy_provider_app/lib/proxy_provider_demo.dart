import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login {
  String username;
  String password;

  Login({required this.username, required this.password});
}

class Employee {
  final int empId;
  final String empName;
  final String username;
  final String password;

  const Employee({
    required this.empId,
    required this.empName,
    required this.username,
    required this.password,
  });
}

class ProxyProviderDemo extends StatelessWidget {
  const ProxyProviderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) {
            return Login(
                username: "aditya_flutter", password: "aditya@flutter");
          },
        ),
        ProxyProvider<Login, Employee>(
          update: (context, login, employee) {
            return Employee(
              empId: 001,
              empName: "Aditya",
              username: login.username,
              password: Provider.of<Login>(context).password,
            );
          },
        ),
      ],
      child: const MaterialApp(
        /// debugShowCheckedModeBanner: false,
        home: UI(),
      ),
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
        title: const Text("Proxy Provider App"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // username
            Text(Provider.of<Login>(context).username),
            const SizedBox(height: 20),

            // password
            Text(Provider.of<Login>(context).password),
            const SizedBox(height: 20),

            // employee Id
            Text("${Provider.of<Employee>(context).empId}"),
            const SizedBox(height: 20),

            // employee name
            Text(Provider.of<Employee>(context).empName),
          ],
        ),
      ),
    );
  }
}
