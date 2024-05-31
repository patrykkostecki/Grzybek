import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Interpreter? interpreter;
  List<String> labels = [];
  bool isModelLoaded = false;

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
                        .substring(2), // Remove first two characters
                    'value': double.parse((e.value * 100).toStringAsFixed(2))
                  };
                })
                .toList()
                .cast<Map<String, dynamic>>();

            // Sort the results by value in descending order and take the top 3
            _classificationResults!
                .sort((a, b) => b['value'].compareTo(a['value']));
            _classificationResults = _classificationResults!.take(3).toList();
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

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.6;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 35),
        Container(
          height: 270,
          width: 270,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 0, 25, 46), width: 4.0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _image != null
                ? Image.file(_image!, fit: BoxFit.cover)
                : Image.asset(
                    'assets/Animations/Szukaj.gif', // Path to your GIF file
                    fit: BoxFit.cover,
                  ), // Display the GIF
          ),
        ),
        SizedBox(height: 20),
        if (_classificationResults != null)
          Column(
            children: _classificationResults!.map((result) {
              // Generate a color, height, and text size for each container based on its index
              Color containerColor;
              double containerHeight;
              double textSize;
              if (edibleMushrooms.contains(result['label'])) {
                containerColor =
                    Color.fromARGB(255, 57, 131, 59).withOpacity(0.8);
              } else {
                containerColor =
                    Color.fromARGB(255, 158, 31, 22).withOpacity(0.8);
              }
              switch (_classificationResults!.indexOf(result)) {
                case 0:
                  containerHeight = 70; // Largest container
                  textSize = 26; // Largest text size
                  break;
                case 1:
                  containerHeight = 35; // Medium container
                  textSize = 14; // Medium text size
                  break;
                case 2:
                  containerHeight = 35; // Smallest container
                  textSize = 14; // Smallest text size
                  break;
                default:
                  containerHeight = 40;
                  textSize = 16;
              }
              return Container(
                height: containerHeight,
                width: containerWidth,
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${result['label']} - ${result['value']}%',
                    style: TextStyle(color: Colors.white, fontSize: textSize),
                  ),
                ),
              );
            }).toList(),
          ),
        if (_classificationResults == null && _image != null)
          Center(child: CircularProgressIndicator()),
        SizedBox(height: 10),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isModelLoaded ? pickImage : null,
                    child: Text('Wybierz Zdjęcie'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Color.fromARGB(255, 15, 113, 143), // Kolor tła
                      shadowColor: Colors.black, // Kolor cienia
                      minimumSize: Size(150, 50),
                      elevation: 8, // Intensywność cienia
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(
                        color:
                            Color.fromARGB(255, 255, 255, 255), // Kolor ramki
                        width: 4,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: isModelLoaded ? takePhoto : null,
                    child: Text('Zrób Zdjęcie'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Color.fromARGB(255, 15, 113, 143), // Kolor tła
                      shadowColor: Colors.black, // Kolor cienia
                      minimumSize: Size(150, 50),
                      elevation: 8, // Intensywność cienia
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      side: BorderSide(
                        color: Colors.white, // Kolor ramki
                        width: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
