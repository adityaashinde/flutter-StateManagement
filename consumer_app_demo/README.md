# consumer_app_demo

## Consumer

- When we use a change notifier provider and we change the data present in the provider and call the notifyListners method it will rebuild the widget tree and will call the build methods of the descendant classes wherethe changeNotifierProvider is used.
- The descendants where changeNotifierProvider is used but no change has happeed will also get rebuilt.

```
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      child: const MaterialApp(
        home: MatchSummary(),
      ),
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

              // Match class
              Text("${Provider.of<Match>(context).matchNo}"),
              const SizedBox(height: 50),
              Text("${Provider.of<Match>(context).runs}"),
              const SizedBox(height: 50),

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
    return Text("${Provider.of<Match>(context).matchNo}");
  }
}

```

- Debug Console Output :

```
[log] In MainApp class Build
[log] In MatchSummary class Build
[log] In Normal class Build
```

- and we change the data then call is only two build

```
[log] In MatchSummary class Build
[log] In Normal class Build
```

<br>
<br>

- To avoid the above problem we will a consumer widget. The consumer widget just builds the part of the code returned form the builder. The entire build method will not get executed.
- The Consumer calls the buildWithChild method to get latest data from the provider.

```
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

```

- When we use the provider before letting the Provider initialize it will throw an error.

<!--  Error ScreenShot -->

- Output :
  <br>
- ![Screenshot (399)](https://github.com/adityaashinde/flutter-StateManagement/assets/94387380/db7dac80-a784-4e24-a0d6-852f9ce7cdce)

<br>
<br>
<br>

- the Provider throw an error.

```
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
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purpleAccent.shade400,
            title: const Text("Provider(Consumer) Demo"),
          ),
          body: Text(Provider.of<Player>(context).playerName),
        ),
      ),
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

```

  <br>
- Output :
  <br>
<!--  Error ScreenShot -->
