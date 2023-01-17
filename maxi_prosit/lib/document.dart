import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'mobile.dart' if (dart.library.html) 'web.dart';
import 'package:flutter/services.dart';
import 'database.dart';

double listBoxLength = 200;

DataBase db = DataBase();

String prositUrl = "";
String prositTitle = "";

// Keywords :
Map<int, Row> mapKeyWords = {};
Map<int, TextEditingController> mapKeyWordsControllers = {};
int keyWordIndex = mapKeyWordsControllers.length;

//Context :
String stringContext = "";

//Problem :
Map<int, Row> mapProblem = {};
Map<int, TextEditingController> mapProblemControllers = {};
int problemIndex = mapProblemControllers.length;

//Constraint :
Map<int, Row> mapConstraint = {};
Map<int, TextEditingController> mapConstraintControllers = {};
int constraintIndex = mapConstraintControllers.length;

//Deliverable :
Map<int, Row> mapDeliverable = {};
Map<int, TextEditingController> mapDeliverableControllers = {};
int deliverableIndex = mapDeliverableControllers.length;

//Generelazing :
Map<int, Row> mapGenerelazing = {};
Map<int, TextEditingController> mapGenerelazingControllers = {};
int generelazingIndex = mapGenerelazingControllers.length;

//Hypothesis :
Map<int, Row> mapHypothesis = {};
Map<int, TextEditingController> mapHypothesisControllers = {};
int hypothesisIndex = mapHypothesisControllers.length;

// Solutions :
Map<int, Row> mapSolutions = {};
Map<int, TextEditingController> mapSolutionsControllers = {};
int solutionsIndex = mapSolutionsControllers.length;

// Actions :
Map<int, Row> mapAction = {};
Map<int, TextEditingController> mapActionControllers = {};
int actionIndex = mapActionControllers.length;

class DocumentPage extends StatefulWidget {
  final int ID;
  const DocumentPage({Key? key, required this.ID}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  int currentIndex = 0;
  late Widget documentNameWidget = Text(db.documentName);
  List<String> pagesNames = const [
    "Informations",
    "Mot(s) Clé(s)",
    "Contexte",
    "Problématique(s)",
    "Contrainte(s)",
    "Livrable(s)",
    "Généralisation(s)",
    "Hypothèse(s)",
    "Piste(s) de Solutions",
    "Plan d'Action",
  ];
  @override
  Widget build(BuildContext context) {
    db.documentID = widget.ID;
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
        centerTitle: true,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(db.documentID.toString()),
              documentNameWidget,
              const Text(" "),
              GestureDetector(
                child: const Icon(Icons.border_color,
                    color: Colors.black, size: 20),
                onTap: () {
                  setState(
                    () {
                      documentNameWidget = Container(
                        width: 200,
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: TextField(
                          cursorColor: Colors.black,
                          onSubmitted: (text) {
                            if (text == "") {
                              db.documentName = "Nouveau Document";
                            } else {
                              db.documentName = text;
                            }
                            setState(() {
                              documentNameWidget = Text(db.documentName);
                            });
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: db.documentName,
                          ),
                        ),
                      );
                    },
                  );
                },
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
  switch (currentIndex) {
    case 0:
      return const InformationPage();
    case 1:
      return const KeyWordsPage();

    case 2:
      return const ContextPage();

    case 3:
      return const ProblemPage();

    case 4:
      return const ConstraintPage();

    case 5:
      return const DeliverablePage();

    case 6:
      return const GenerelazingPage();

    case 7:
      return const HypothesisPage();

    case 8:
      return const SolutionsPage();

    case 9:
      return const ActionPage();

    default:
      return const Text("Error");
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
    TextEditingController titleController = TextEditingController();
    TextEditingController urlController = TextEditingController();
    titleController.text = prositTitle;
    urlController.text = prositUrl;
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
                      db.prositTitle = value;
                    },
                    controller: titleController,
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
                      db.prositUrl = value;
                    },
                    controller: urlController,
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

class KeyWordsPage extends StatefulWidget {
  const KeyWordsPage({super.key});
  @override
  State<KeyWordsPage> createState() => _KeyWordsPageState();
}

class _KeyWordsPageState extends State<KeyWordsPage> {
  Row row(index) {
    mapKeyWordsControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 250,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            controller: mapKeyWordsControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Mot clé",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapKeyWords.isEmpty) {
      keyWordIndex = 0;
      mapKeyWords[keyWordIndex] = row(keyWordIndex);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //for (var item in listKeyWordString) item,
            for (var item in mapKeyWords.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter un mot clé",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      keyWordIndex++;
                      mapKeyWords[keyWordIndex] = row(keyWordIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapKeyWords.isEmpty) return;
                      mapKeyWords.remove(keyWordIndex);
                      keyWordIndex--;
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

class ContextPage extends StatefulWidget {
  const ContextPage({super.key});
  @override
  State<ContextPage> createState() => _ContextPageState();
}

class _ContextPageState extends State<ContextPage> {
  TextEditingController textarea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textarea.text = stringContext;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 250,
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: TextField(
                    maxLines: null,
                    cursorColor: Colors.black,
                    controller: textarea,
                    onChanged: (value) {
                      stringContext = value;
                    },
                    decoration: const InputDecoration(
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(),
                      hintText: "Contexte",
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProblemPage extends StatefulWidget {
  const ProblemPage({super.key});
  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  Row row(index) {
    mapProblemControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 300,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            controller: mapProblemControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Problématique",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapProblem.isEmpty) {
      problemIndex = 0;
      mapProblem[problemIndex] = row(problemIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //for (var item in listKeyWordString) item,
            for (var item in mapProblem.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter une problématique",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      problemIndex++;
                      mapProblem[problemIndex] = row(problemIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapProblem.isEmpty) return;
                      mapProblem.remove(problemIndex);
                      problemIndex--;
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

class ConstraintPage extends StatefulWidget {
  const ConstraintPage({super.key});
  @override
  State<ConstraintPage> createState() => _ConstraintPageState();
}

class _ConstraintPageState extends State<ConstraintPage> {
  Row row(index) {
    mapConstraintControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 300,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            controller: mapConstraintControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Contrainte",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapConstraint.isEmpty) {
      constraintIndex = 0;
      mapConstraint[constraintIndex] = row(constraintIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //for (var item in listKeyWordString) item,
            for (var item in mapConstraint.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter une contrainte",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      constraintIndex++;
                      mapConstraint[constraintIndex] = row(constraintIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapConstraint.isEmpty) return;
                      mapConstraint.remove(constraintIndex);
                      constraintIndex--;
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

class DeliverablePage extends StatefulWidget {
  const DeliverablePage({super.key});
  @override
  State<DeliverablePage> createState() => _DeliverablePageState();
}

class _DeliverablePageState extends State<DeliverablePage> {
  Row row(index) {
    mapDeliverableControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 300,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            controller: mapDeliverableControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Livrable",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapDeliverable.isEmpty) {
      deliverableIndex = 0;
      mapDeliverable[deliverableIndex] = row(deliverableIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //for (var item in listKeyWordString) item,
            for (var item in mapDeliverable.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter un livrable",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      deliverableIndex++;
                      mapDeliverable[deliverableIndex] = row(deliverableIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapDeliverable.isEmpty) return;
                      mapDeliverable.remove(deliverableIndex);
                      deliverableIndex--;
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

class GenerelazingPage extends StatefulWidget {
  const GenerelazingPage({super.key});
  @override
  State<GenerelazingPage> createState() => _GenerelazingPageState();
}

class _GenerelazingPageState extends State<GenerelazingPage> {
  Row row(index) {
    mapGenerelazingControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 300,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            controller: mapGenerelazingControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Généralisation",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapGenerelazing.isEmpty) {
      generelazingIndex = 0;
      mapGenerelazing[generelazingIndex] = row(generelazingIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //for (var item in listKeyWordString) item,
            for (var item in mapGenerelazing.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter une généralisation",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      generelazingIndex++;
                      mapGenerelazing[generelazingIndex] =
                          row(generelazingIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapGenerelazing.isEmpty) return;
                      mapGenerelazing.remove(generelazingIndex);
                      generelazingIndex--;
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

class HypothesisPage extends StatefulWidget {
  const HypothesisPage({super.key});
  @override
  State<HypothesisPage> createState() => _HypothesisPageState();
}

class _HypothesisPageState extends State<HypothesisPage> {
  Row row(index) {
    mapHypothesisControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 300,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            onChanged: (value) {},
            controller: mapHypothesisControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Hypothèse",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapHypothesis.isEmpty) {
      hypothesisIndex = 0;
      mapHypothesis[hypothesisIndex] = row(hypothesisIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //for (var item in listKeyWordString) item,
            for (var item in mapHypothesis.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter une hypothèse",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      hypothesisIndex++;
                      mapHypothesis[hypothesisIndex] = row(hypothesisIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapHypothesis.isEmpty) return;
                      mapHypothesis.remove(hypothesisIndex);
                      hypothesisIndex--;
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

class SolutionsPage extends StatefulWidget {
  const SolutionsPage({super.key});
  @override
  State<SolutionsPage> createState() => _SolutionsPageState();
}

class _SolutionsPageState extends State<SolutionsPage> {
  Row row(index) {
    mapSolutionsControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 300,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            onChanged: (value) {},
            controller: mapSolutionsControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Piste de solution",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapSolutions.isEmpty) {
      solutionsIndex = 0;
      mapSolutions[solutionsIndex] = row(solutionsIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var item in mapSolutions.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter une piste de solutions",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      solutionsIndex++;
                      mapSolutions[solutionsIndex] = row(solutionsIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapSolutions.isEmpty) return;
                      mapSolutions.remove(solutionsIndex);
                      solutionsIndex--;
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

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});
  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  Row row(index) {
    mapActionControllers[index] = TextEditingController();
    return Row(
      children: [
        Container(
          width: 300,
          alignment: Alignment.centerLeft,
          color: Colors.white,
          child: TextField(
            onChanged: (value) {},
            controller: mapActionControllers[index],
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              hoverColor: Colors.black,
              border: OutlineInputBorder(),
              hintText: "Action",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mapAction.isEmpty) {
      actionIndex = 0;
      mapAction[actionIndex] = row(actionIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var item in mapAction.values) item,
            Row(
              children: [
                ElevatedButton(
                  child: const Text("Ajouter une action",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      actionIndex++;
                      mapAction[actionIndex] = row(actionIndex);
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Supprimer",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      if (mapAction.isEmpty) return;
                      mapAction.remove(actionIndex);
                      actionIndex--;
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
  /*PdfDocument document = PdfDocument();
  document.pages.add();

  List<int> bytes = await document.save();
  document.dispose();

  saveAndLaunchFile(bytes, '$documentName.pdf');*/
}
