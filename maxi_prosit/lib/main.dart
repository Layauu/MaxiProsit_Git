import 'package:flutter/material.dart';
import 'document.dart';
import 'package:get/get.dart';

Text platForm() {
  if (GetPlatform.isAndroid) {
    return const Text("Android");
  }
  if (GetPlatform.isIOS) {
    return const Text("IOS");
  }
  if (GetPlatform.isLinux) {
    return const Text("Linux");
  }
  if (GetPlatform.isMacOS) {
    return const Text("MacOS");
  }
  if (GetPlatform.isWeb) {
    return const Text("Web");
  }
  if (GetPlatform.isWindows) {
    return const Text("Windows");
  }
  return const Text("Error");
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compte Rendu Prosit',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: "Cascadia Code",
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            platForm(),
            const Icon(Icons.home),
            const Text(" Accueil"),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const DocumentPage();
                        },
                      ),
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add),
                    Text(" Nouveau Document"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
