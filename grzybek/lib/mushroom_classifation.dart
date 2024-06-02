import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grzybek/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ClassifierWidget extends StatefulWidget {
  @override
  _ClassifierWidgetState createState() => _ClassifierWidgetState();
}

class _ClassifierWidgetState extends State<ClassifierWidget> {
  File? _image;
  List<Map<String, dynamic>>? _classificationResults;
  List<Map<String, dynamic>>? _displayedResults = [];
  Interpreter? interpreter;
  List<String> labels = [];
  bool isModelLoaded = false;
  List<double> opacities = [0.0, 0.0, 0.0]; // Initialize with 0 opacity

  // List of edible mushrooms
  final List<String> edibleMushrooms = [
    'Pieczarka',
    'Borowik',
    'Rydz',
    'Gołąbek',
    'Maślak'
  ];

  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      setState(() {
        isModelLoaded = true;
      });
    });
    loadLabels();
  }

  Future<void> loadLabels() async {
    try {
      final labelData =
          await rootBundle.loadString('assets/Labels/labels3.txt');
      setState(() {
        labels =
            labelData.split('\n').where((label) => label.isNotEmpty).toList();
      });
      print("Labels loaded: $labels");
    } catch (e) {
      print("Error loading labels: $e");
    }
  }

  Future<void> loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset('assets/models/model_unquant3.tflite');
      print("Model loaded successfully");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _displayedResults = [];
        opacities = [0.0, 0.0, 0.0];
      });
      print("Image picked: ${pickedFile.path}");
      classifyImage();
    } else {
      print("No image selected");
    }
  }

  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _displayedResults = [];
        opacities = [0.0, 0.0, 0.0];
      });
      print("Photo taken: ${pickedFile.path}");
      classifyImage();
    } else {
      print("No photo taken");
    }
  }

  Uint8List imageToByteListFloat32(img.Image image, int inputSize) {
    var convertedBytes = Float32List(inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) / 255.0);
        buffer[pixelIndex++] = (img.getGreen(pixel) / 255.0);
        buffer[pixelIndex++] = (img.getBlue(pixel) / 255.0);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Future<void> classifyImage() async {
    if (_image != null && interpreter != null) {
      try {
        print("Classifying image...");
        var imageBytes = await File(_image!.path).readAsBytes();
        var image = img.decodeImage(imageBytes);
        if (image != null) {
          print("Image decoded successfully");
          var resizedImage = img.copyResize(image, width: 224, height: 224);
          var input = imageToByteListFloat32(resizedImage, 224);

          print(
              "Input shape: [${resizedImage.width}, ${resizedImage.height}, 3]");
          print("Input data length: ${input.length}");

          var inputBuffer = input.buffer.asFloat32List();
          var inputTensor = inputBuffer.reshape([1, 224, 224, 3]);
          var output = List.filled(9, 0.0).reshape([1, 9]);

          print("Output shape: [1, 9]");

          interpreter!.run(inputTensor, output);
          print("Raw output: $output");

          setState(() {
            _classificationResults = output[0]
                .asMap()
                .entries
                .map((e) {
                  return {
                    'label': labels[e.key]
                        .substring(2)
                        .trim(), // Remove first two characters and trim
                    'value': double.parse((e.value * 100).toStringAsFixed(2))
                  };
                })
                .toList()
                .cast<Map<String, dynamic>>();

            // Sort the results by value in descending order and take the top 3
            _classificationResults!
                .sort((a, b) => b['value'].compareTo(a['value']));
            _classificationResults = _classificationResults!.take(3).toList();

            // Display results one by one with fade-in effect
            showResultsSequentially();

            // Display the appropriate animation in a dialog after 5 seconds
            Future.delayed(Duration(seconds: 5), showClassificationAnimation);
          });
          print("Top 3 classification results: $_classificationResults");
        } else {
          print("Problem with decoding the image");
        }
      } catch (e) {
        print('Error during image classification: $e');
      }
    } else {
      if (_image == null) {
        print('No image selected.');
      }
      if (interpreter == null) {
        print('Interpreter not initialized.');
      }
    }
  }

  void showResultsSequentially() async {
    for (int i = 0; i < _classificationResults!.length; i++) {
      setState(() {
        _displayedResults!.add(_classificationResults![i]);
      });
      await Future.delayed(
          Duration(milliseconds: 500)); // Short delay before starting fade-in
      setState(() {
        opacities[i] = 1.0;
      });
      await Future.delayed(
          Duration(seconds: 1)); // Delay to keep the fade-in effect visible
    }
  }

  void showClassificationAnimation() {
    // Determine which GIF to show
    bool isEdible =
        edibleMushrooms.contains(_classificationResults![0]['label']);
    String gifPath = isEdible
        ? 'assets/Animations/Jadalny2.gif'
        : 'assets/Animations/Trujcy1.gif';

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              const Color.fromARGB(255, 146, 127, 127).withOpacity(0.9),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  gifPath,
                  key: UniqueKey(), // Ensure the GIF restarts
                  width: 250, // Adjust the size as needed
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 200, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: AppButtonStyles.primaryButtonStyle,
                  child: AppButtonStyles.getGradientInk(
                    'Powrót', // Set the text color if needed
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.7;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25),
            Container(
              height: MediaQuery.of(context).size.width * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 189, 165, 130),
                    width: 4.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Image.asset(
                        'assets/Animations/Scanner.gif',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: 20),
            if (_displayedResults != null)
              Column(
                children: _displayedResults!.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> result = entry.value;

                  // Logowanie debugujące
                  print("Predykcja: ${result['label']} - ${result['value']}%");
                  print(
                      "Czy jest jadalny: ${edibleMushrooms.contains(result['label'])}");

                  // Generate a color, height, and text size for each container based on its index
                  Color containerColor;
                  double containerHeight;
                  double textSize;
                  List<Color> gradientColors;
                  if (edibleMushrooms.contains(result['label'])) {
                    gradientColors = [
                      Color.fromARGB(255, 57, 131, 59).withOpacity(0.8),
                      Color.fromARGB(255, 0, 83, 38).withOpacity(0.8),
                    ]; // Zielony dla jadalnych
                  } else {
                    gradientColors = [
                      Color.fromARGB(255, 158, 31, 22).withOpacity(0.8),
                      Color.fromARGB(255, 77, 0, 0).withOpacity(0.8),
                    ]; // Czerwony dla niejadalnych
                  }
                  switch (index) {
                    case 0:
                      containerHeight = 70; // Largest container
                      textSize = 20; // Largest text size
                      break;
                    case 1:
                      containerHeight = 40; // Medium container
                      textSize = 14; // Medium text size
                      break;
                    case 2:
                      containerHeight = 40; // Smallest container
                      textSize = 14; // Smallest text size
                      break;
                    default:
                      containerHeight = 40;
                      textSize = 16;
                  }
                  return AnimatedOpacity(
                    opacity: opacities[index],
                    duration: Duration(seconds: 1),
                    child: Container(
                      height: containerHeight,
                      width: containerWidth,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 7), // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                          color: Color.fromARGB(255, 189, 165, 130),
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${result['label']} - ${result['value']}%',
                          style: TextStyle(
                              color: Color.fromARGB(255, 229, 215, 194),
                              fontSize: textSize),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            if (_displayedResults == null && _image != null)
              Center(child: CircularProgressIndicator()),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isModelLoaded ? pickImage : null,
                        style: AppButtonStyles.primaryButtonStyle,
                        child: AppButtonStyles.getGradientInk(
                          'Wybierz Zdjęcie',
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isModelLoaded ? takePhoto : null,
                        style: AppButtonStyles.primaryButtonStyle,
                        child: AppButtonStyles.getGradientInk(
                          'Zrób Zdjęcie',
                          borderRadius: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
