import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    log("In MainApp class Build");
    return MultiProvider(
      providers: [
        Provider(
          create: (context) {
            return Player(playerName: "Virat", jerNo: 18);
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return Match(matchNo: 200, runs: 8700);
          },
        ),
      ],
      child: const MatchSummary(),
    );
  }
}

class Player {
  String playerName;
  int jerNo;

  Player({required this.playerName, required this.jerNo});
}

class Match with ChangeNotifier {
  int matchNo;
  int runs;

  Match({required this.matchNo, required this.runs});

  void changeData(int matchNo, int runs) {
    this.matchNo = matchNo;
    this.runs = runs;
    notifyListeners();
  }
}

class MatchSummary extends StatefulWidget {
  const MatchSummary({super.key});

  @override
  State createState() => _MatchSummaryState();
}

class _MatchSummaryState extends State {
  @override
  Widget build(BuildContext context) {
    log("In MatchSummary class Build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Provider(Consumer) Demo App"),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Player class
              Text(Provider.of<Player>(context).playerName),
              const SizedBox(height: 50),
              Text("${Provider.of<Player>(context).jerNo}"),
              const SizedBox(height: 50),

              // Consumer
              Consumer(builder: (context, provider, child) {
                log("In Consumer");
                return Column(
                  children: [
                    Text("${Provider.of<Match>(context).matchNo}"),
                    const SizedBox(height: 50),
                    Text("${Provider.of<Match>(context).runs}"),
                    const SizedBox(height: 50),
                  ],
                );
              }),

              // Elevated Button
              ElevatedButton(
                onPressed: () {
                  Provider.of<Match>(context, listen: false)
                      .changeData(221, 9780);
                },
                child: const Text("Change Data"),
              ),
              const SizedBox(height: 50),
              const NormalClass(),
            ],
          ),
        ],
      ),
    );
  }
}

class NormalClass extends StatelessWidget {
  const NormalClass({super.key});

  @override
  Widget build(BuildContext context) {
    log("In Normal class Build");
    return Consumer(
      builder: (context, value, child) {
        log("In Normal class consumer");
        return Text("${Provider.of<Match>(context).matchNo}");
      },
    );
  }
}
