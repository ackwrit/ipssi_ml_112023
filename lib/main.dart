import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mlearning_ippsi112023/controller/MyCustomPaint.dart';
import 'package:mlearning_ippsi112023/controller/my_permission_photo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PermissionPhoto().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  TextEditingController phrase = TextEditingController();
  String langueIdentifier = "";
  LanguageIdentifier langue = LanguageIdentifier(confidenceThreshold: 0.3);

  //méthodes
  //identifier la langue
  uniqueLangueIndentifier() async {
    langueIdentifier = "";
    String str = "";
    if (phrase.text != "") {
      str = await langue.identifyLanguage(phrase.text);
    }
    setState(() {
      langueIdentifier = "La langue est $str";
    });
  }

  pluseiursLangueIdentifier() async {
    langueIdentifier = "";
    List str = [];
    if (phrase != "") {
      str = await langue.identifyPossibleLanguages(phrase.text);
      for (IdentifiedLanguage label in str) {
        setState(() {
          langueIdentifier +=
              "la langue est ${label.languageTag} avec une confiance de ${(label.confidence * 100).toInt()} %\n";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Machine Learning"),
      ),
      body: Column(
        children: [
          TextField(
            controller: phrase,
          ),
          ElevatedButton(
              onPressed: uniqueLangueIndentifier,
              child: const Text("Detecter langue")),
          ElevatedButton(
              onPressed: pluseiursLangueIdentifier,
              child: const Text("Detecter plusieurs langues")),
          Text(langueIdentifier)
        ],
      ),
    );
  }
}
