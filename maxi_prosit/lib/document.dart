import 'package:flutter/cupertino.dart';
import 'notweb.dart' if (dart.library.html) 'web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
  late Widget documentNameWidget = Text(db.a[0][0]);
  @override
  Widget build(BuildContext context) {
    db = DataBase(widget.iD);
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
                      if (GetPlatform.isMobile ||
                          (MediaQuery.of(context).size.width < 500)) {
                        Navigator.pop(context);
                      }
                    });
                  }
                : null,
          ),
        );
      },
    );

    final col = Column(
      children: <Widget>[
        Expanded(
          child: pageList,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(CupertinoIcons.arrow_down_doc),
          title: const Text('Exporter en PDF'),
          onTap: () {
            makePdf(context);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
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
                            db.a[0][0] = text;
                            documentNameWidget = Text(db.a[0][0]);
                            db.saveData();
                          });
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: db.a[0][0],
                        ),
                      ),
                    );
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
              child: col,
            )
          : null,
      body: Row(
        children: [
          if ((!GetPlatform.isMobile) &&
              (MediaQuery.of(context).size.width >= 500))
            SizedBox(
              width: listBoxLength,
              child: col,
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
            const Text(
              "Titre du prosit : ",
              style: TextStyle(fontSize: 24),
            ),
            const Divider(height: 16),
            Container(
              width: 250,
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: TextField(
                onChanged: (value) {
                  db.a[0][1] = value;
                  db.saveData();
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
            const Divider(height: 32),
            const Text(
              "Url du prosit : ",
              style: TextStyle(fontSize: 24),
            ),
            const Divider(height: 16),
            Container(
              width: 250,
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: TextField(
                maxLines: null,
                onChanged: (value) {
                  db.a[0][2] = value;
                  db.saveData();
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
              maxLines: null,
              onChanged: (value) {
                db.a[widget.pageIndex][index] = value;
                db.saveData();
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
          const Text(" "),
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.red.shade400,
            heroTag: index,
            onPressed: () {
              setState(() {
                db.a[widget.pageIndex].removeAt(index);
                db.saveData();
              });
            },
            child: const Icon(CupertinoIcons.trash),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              pagesNames[widget.pageIndex],
              style: const TextStyle(fontSize: 24),
            ),
            const Divider(height: 16),
            Column(
              children: List.generate(db.a[widget.pageIndex].length, (index) {
                return row(index);
              }),
            ),
            const Divider(height: 10),
            SizedBox(
              height: 45,
              width: 125,
              child: FittedBox(
                child: FloatingActionButton.extended(
                  heroTag: HeroController(),
                  onPressed: () {
                    setState(() {
                      db.a[widget.pageIndex].add("");
                      db.saveData();
                    });
                  },
                  label: Row(
                    children: const [
                      Icon(CupertinoIcons.add),
                      Text(" Ajouter", style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void makePdf(context) async {
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Divider(
            thickness: 1,
          ),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.max,
            children: [
              pw.Expanded(
                child: pw.Text(
                  db.a[0][0],
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
          pw.Divider(
            thickness: 1,
          ),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.max,
            children: [
              pw.Expanded(
                child: pw.Text(
                  'Titre du prosit : ${db.a[0][1]} ',
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
          pw.Text('\n\n\n'),
          for (int i = 1; i < db.a.length; i++) ...[
            pw.Row(
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.Text('${pagesNames[i]} : '),
              ],
            ),
            pw.Text("\n"),
            for (int j = 0; j < db.a[i].length; j++)
              pw.Row(
                children: [
                  pw.Text(
                    ' - ${db.a[i][j]}',
                  ),
                ],
              ),
            pw.Text("\n\n"),
          ],
          pw.Divider(
            thickness: 1,
          ),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.max,
            children: [
              pw.Expanded(
                child: pw.Text(
                  'URL du Prosit : ${db.a[0][2]}',
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
        ];
      },
    ),
  );
  final pdfFile = CreatePDFfile(pdf, db.a[0][0]);
  pdfFile.create();
}
