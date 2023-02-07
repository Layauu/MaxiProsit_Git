import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'document.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database.dart';

DataBase db = DataBase(0);

void main() async {
  // init the hive
  await Hive.initFlutter();
  await Hive.openBox('box');

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
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(" Maxi Prosit"),
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
                  FloatingActionButton.extended(
                    heroTag: HeroController(),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(CupertinoIcons.doc_text),
                        Text(" Nouveau Document"),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        _navigateAndDisplaySelection(
                            context, DocumentPage(iD: db.getTheNextKey()));
                      });
                    },
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 32),
                          for (int i = 0; i < _box.length; i++) ...[
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _navigateAndDisplaySelection(context,
                                          DocumentPage(iD: _box.keyAt(i)));
                                    });
                                  },
                                  child: Text(_box.getAt(i)[0][0],
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ),
                                const Text(' '),
                              ],
                            ),
                            const Divider(height: 16)
                          ]
                        ],
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < _box.length; i++) ...[
                            edit
                                ? Row(children: [
                                    FloatingActionButton(
                                      mini: true,
                                      backgroundColor: Colors.red.shade400,
                                      heroTag: HeroController(),
                                      onPressed: () {
                                        showAlertDialog(context, i, _box)
                                            .then((_) => setState(() {}));
                                      },
                                      child: const Icon(CupertinoIcons.trash),
                                    ),
                                    FloatingActionButton(
                                      mini: true,
                                      backgroundColor: Colors.blue.shade400,
                                      heroTag: HeroController(),
                                      onPressed: () {
                                        setState(() {
                                          _box.put(db.getTheNextKey(),
                                              _box.getAt(i));
                                        });
                                      },
                                      child: const Icon(
                                          CupertinoIcons.plus_square_on_square),
                                    ),
                                  ])
                                : const Text(""),
                            const Divider(height: 4)
                          ]
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            edit = !edit;
          });
        },
        child: const Icon(CupertinoIcons.bars),
      ),
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

  Widget cancelButton = FloatingActionButton.extended(
    backgroundColor: Colors.red,
    label: const Text("Annuler", style: TextStyle(color: Colors.black)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FloatingActionButton.extended(
    label: const Text("Continuer"),
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
