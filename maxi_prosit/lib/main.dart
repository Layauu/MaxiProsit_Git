import 'package:flutter/material.dart';
import 'document.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database.dart';
import 'package:permission_handler/permission_handler.dart';

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

Permission storage = Permission.unknown;
PermissionStatus status = PermissionStatus.restricted;
void f() async {
  status = await storage.status;
}

void main() async {
  // init the hive
  if (GetPlatform.isAndroid) {
    storage = Permission.manageExternalStorage;
  } else {
    storage = Permission.storage;
  }
  await Hive.initFlutter();
  await Hive.openBox('box');
  // open the box
  final box = Hive.box('box');
  print(box.length);
  for (int i = 0; i < box.length; i++) print(box.getAt(i));
  f();
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
                        _navigateAndDisplaySelection(
                            context, DocumentPage(iD: db.getTheNextKey()));
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
                              _navigateAndDisplaySelection(
                                  context, DocumentPage(iD: _box.keyAt(i)));
                            });
                          },
                          child: Text(_box.getAt(i)[0][0]),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showAlertDialog(context, i, _box)
                                .then((_) => setState(() {}));
                            //_box.deleteAt(i);
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
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                const Text('Storage : '),
                (status.isGranted)
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.no_accounts, color: Colors.red),
                (status.isRestricted) ? Text("hey") : Text(""),
              ],
            ),
            onTap: () async {
              setState(() async {
                if (status.isGranted) {
                  print('granted');
                }
                if (status.isDenied) {
                  print('denied');
                  await storage.request();
                }
                if (status.isPermanentlyDenied) {
                  print('permanentlyDenied');

                  openAppSettings();
                }
              });
              //setState(() {});
            },
          ),
        ],
      )),
    );
  }

  void _navigateAndDisplaySelection(
      BuildContext context, Widget document) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => document),
    );
    setState(() {});
  }
}

Future<void> showAlertDialog(
    BuildContext context, int docIndex, Box box) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Annuler"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continuer"),
    onPressed: () {
      box.deleteAt(docIndex);
      Navigator.of(context).pop();
    },
  );
  String text = "Voulez vous vraiment supprimer ${box.getAt(docIndex)[0][0]} ?";
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Attention !"),
    content: Text(text),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
