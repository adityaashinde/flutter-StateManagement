import 'package:flutter/material.dart';
import 'package:proxy_provider_app/change_proxy_demo.dart';
// import 'package:proxy_provider_app/proxy_provider_demo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      // home: ProxyProviderDemo(),
      home: ChangeProxyDemo(),
    );
  }
}
