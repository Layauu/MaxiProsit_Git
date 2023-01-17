import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'mobile.dart' if (dart.library.html) 'web.dart';
import 'package:flutter/services.dart';
import 'database.dart';

double listBoxLength = 200;

DataBase db = DataBase(0);

List<String> pagesNames = const [
  "Informations",
  "Mot(s) Clé(s)",
  "Contexte(s)",
  "Problématique(s)",
  "Contrainte(s)",
  "Livrable(s)",
  "Généralisation(s)",
  "Hypothèse(s)",
  "Piste(s) de Solutions",
  "Plan d'Action",
];

class DocumentPage extends StatefulWidget {
  final int iD;
  const DocumentPage({Key? key, required this.iD}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  int currentIndex = 0;
  String documentName = "yo";
  late Widget documentNameWidget = Text(documentName);
  @override
  Widget build(BuildContext context) {
    db = DataBase(widget.iD);
    documentName = db.a[0][0];
    late ListView pageList = ListView.builder(
      itemCount: pagesNames.length,
      itemBuilder: (context, index) {
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        );
        return Ink(
          color: currentIndex == index
              ? Colors.yellow.shade400
              : Colors.transparent,
          child: ListTile(
            title: Text(pagesNames[index]),
            onTap: (currentIndex != index)
                ? () {
                    setState(() {
                      currentIndex = index;
                    });
                  }
                : null,
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    documentNameWidget = Container(
                      width: 200,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      child: TextField(
                        cursorColor: Colors.black,
                        onSubmitted: (text) {
                          setState(() {
                            db.a[0][0] = "yo";
                            print(db.a[0][0]);
                            documentNameWidget = Text(db.a[0][0]);
                          });
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: db.a[0][0],
                        ),
                      ),
                    );
                    print("works");
                  });
                },
                child: documentNameWidget,
              )
            ],
          ),
        ),
      ),
      endDrawer: GetPlatform.isMobile ||
              (MediaQuery.of(context).size.width < 500) //|| true
          ? Drawer(
              child: pageList,
            )
          : null,
      body: Row(
        children: [
          if ((!GetPlatform.isMobile) &&
              (MediaQuery.of(context).size.width >= 500))
            SizedBox(
              width: listBoxLength,
              child: pageList,
            ),
          SizedBox(
            width: (!GetPlatform.isMobile) &&
                    (MediaQuery.of(context).size.width >= 500) //&& false
                ? MediaQuery.of(context).size.width - listBoxLength
                : MediaQuery.of(context).size.width,
            child: Center(
              child: pageSelector(currentIndex),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.yellow,
        child: InkWell(
          onTap: () {
            createFile();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: const <Widget>[
                Icon(
                  Icons.fiber_new,
                  color: Colors.black,
                ),
                Text('Générer'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget pageSelector(currentIndex) {
  if (currentIndex == 0) {
    return const InformationPage();
  } else {
    return ObjectPage(
      pageIndex: currentIndex,
    );
  }
}

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});
  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                const Text("Titre du prosit : "),
                Container(
                  width: 250,
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: TextField(
                    onChanged: (value) {
                      db.a[0][1] = value;
                    },
                    controller: TextEditingController(text: db.a[0][1]),
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: "",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Url du prosit : "),
                Container(
                  width: 250,
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: TextField(
                    onChanged: (value) {
                      db.a[0][2] = value;
                    },
                    controller: TextEditingController(text: db.a[0][2]),
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: "",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ObjectPage extends StatefulWidget {
  int pageIndex;
  ObjectPage({Key? key, required this.pageIndex}) : super(key: key);
  @override
  State<ObjectPage> createState() => _ObjectPageState();
}

class _ObjectPageState extends State<ObjectPage> {
  @override
  Widget build(BuildContext context) {
    Row row(index) {
      return Row(
        children: [
          Container(
            width: 250,
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: TextFormField(
              onChanged: (value) {
                db.a[widget.pageIndex][index] = value;
              },
              controller:
                  TextEditingController(text: db.a[widget.pageIndex][index]),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hoverColor: Colors.black,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                db.a[widget.pageIndex].removeAt(index);
              });
            },
            child: const Icon(Icons.delete_forever),
          )
        ],
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(pagesNames[widget.pageIndex]),
            Column(
              children: List.generate(db.a[widget.pageIndex].length, (index) {
                return row(index);
              }),
            ),
            Row(
              children: [
                ElevatedButton(
                  child: const Text("+", style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      db.a[widget.pageIndex].add("");
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> createFile() async {
  db.saveData();
}
