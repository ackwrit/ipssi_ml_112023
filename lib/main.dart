import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:mlearning_ippsi112023/controller/MyCustomPaint.dart';
import 'package:mlearning_ippsi112023/controller/my_permission_photo.dart';
import 'package:mlearning_ippsi112023/painters/facepainter.dart';
import 'package:mlearning_ippsi112023/painters/objectPainter.dart';
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
  OnDeviceTranslator translator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.french,
      targetLanguage: TranslateLanguage.bengali);
  String? pathImage;
  ImageLabeler labeler =
      ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.4));
  ObjectDetector objectDetector = ObjectDetector(
      options: ObjectDetectorOptions(
          mode: DetectionMode.single,
          classifyObjects: true,
          multipleObjects: true));
  CustomPaint? customPaint;
  Size? sizeImage;
  Size contour = Size(400, 400);
  FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(
    enableClassification: true,
    enableContours: true,
  ));

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

  traduction() async {
    langueIdentifier = "";
    if (phrase.text != "") {
      String str = await translator.translateText(phrase.text);
      setState(() {
        langueIdentifier = str;
      });
    }
  }

  pickFile() async {
    late File fileImage;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        pathImage = result.files.first.path;
        fileImage = File(pathImage!);
      });
      final bytes = fileImage.readAsBytesSync();
      final images = await decodeImageFromList(bytes);
      final height = images.height.toDouble();
      final width = images.width.toDouble();
      setState(() {
        sizeImage = Size(width, height);
        contour = sizeImage!;
      });
      //listingElement();
      listingObject();
      //listingVisage();
    }
  }

  listingVisage() async {
    langueIdentifier = "";
    InputImage inputImage = InputImage.fromFilePath(pathImage!);
    List<Face> faces = await faceDetector.processImage(inputImage);
    print(faces[0].boundingBox.width);
    customPaint = CustomPaint(
      painter: FacePainter(sizeImage: sizeImage!, objects: faces),
    );
  }

  listingObject() async {
    langueIdentifier = "";
    InputImage inputImage = InputImage.fromFilePath(pathImage!);
    List<DetectedObject> objects =
        await objectDetector.processImage(inputImage);
    customPaint = CustomPaint(
      painter: ObjectPainter(sizeImage: sizeImage!, objects: objects),
    );
  }

  listingElement() async {
    langueIdentifier = "";
    InputImage inputImage = InputImage.fromFilePath(pathImage!);
    List labels = await labeler.processImage(inputImage);
    for (ImageLabel image in labels) {
      setState(() {
        langueIdentifier +=
            "il y'a ${image.label} avec une confiance de ${(image.confidence * 100).toInt()} %\n";
      });
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
      body: SingleChildScrollView(
        child: Column(
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
            ElevatedButton(
                onPressed: traduction, child: const Text("traduitre")),
            ElevatedButton(
                onPressed: pickFile, child: const Text("Image choisi")),

            Container(
              height: contour.height,
              width: contour.width,
              child: Stack(
                children: [
                  (pathImage == null)
                      ? Container()
                      : Image.file(File(pathImage!)),
                  (customPaint == null) ? Container() : customPaint!
                ],
              ),
            )

            //dessiner su l'image un cadre

            //Text(langueIdentifier),
          ],
        ),
      ),
    );
  }
}
