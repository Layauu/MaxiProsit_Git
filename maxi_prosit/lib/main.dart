import 'package:flutter/material.dart';
import 'document.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';
import 'database.dart';

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

DataBase db = DataBase(0);

void main() async {
  // init the hive
  await Hive.initFlutter();
  await Hive.openBox('box');
  // open the box
  final box = Hive.box('box');
  print(box.length);
  for (int i = 0; i < box.length; i++) print(box.getAt(i));
  runApp(const MyApp());
}

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
  // reference the hive box
  final _box = Hive.box('box');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.home),
            Text(" Accueil"),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return DocumentPage(iD: db.getTheNextKey());
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
                  for (int i = 0; i < _box.length; i++)
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return DocumentPage(iD: _box.keyAt(i));
                                  },
                                ),
                              );
                            });
                          },
                          child: Text(_box.getAt(i)[0][0]),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _box.deleteAt(i);
                            });
                          },
                          child: const Icon(Icons.delete_forever),
                        )
                      ],
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
