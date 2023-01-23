import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

final _box = Hive.box('documents');
final _permission = GetPlatform.isAndroid
    ? Permission.manageExternalStorage
    : Permission.storage;

void main() async {
  await Hive.initFlutter();
  await _box.open();
  await _permission.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compte Rendu Prosit',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: "Cascadia Code",
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maxi Prosit"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            heroTag: HeroController(),
            label: const Text("Nouveau Document"),
            icon: const Icon(CupertinoIcons.doc_text),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => DocumentPage()));
            },
          ),
          const Divider(height: 32),
          Expanded(
            child: StreamBuilder(
              stream: _box.watch(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var entries;
                var entries;
                final documents = snapshot.data?.entries;
                return ListView.separated(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return ListTile(
                      title: Text(document.value[0]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => DocumentPage(id: document.key)));
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: 16),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    final document = id != null ? _box.get(id) : ["Nouveau Document"];
    return Scaffold(
      appBar: AppBar(
        title: Text(document[0]),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Titre",
            ),
            initialValue: document[0],
            onChanged: (value) {
              document[0] = value;
              if (id != null) _box.put(id, document);
            },
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: "Contenu",
              ),
              initialValue: document[1],
              onChanged: (value) {
                document[1] = value;
                if (id != null) _box.put(id, document);
              },
            ),
          ),
        ],
      ),
    );
  }
}
