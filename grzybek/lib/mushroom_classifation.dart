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
  List<dynamic>? _classificationResults;
  Interpreter? interpreter;
  List<String> labels = [];
  bool isModelLoaded = false;

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
      final labelData = await rootBundle.loadString('assets/Labels/labels.txt');
      setState(() {
        labels =
            labelData.split('\n').where((label) => label.isNotEmpty).toList();
      });
    } catch (e) {
      print("Error loading labels: $e");
    }
  }

  Future<void> loadModel() async {
    try {
      interpreter =
          await Interpreter.fromAsset('assets/models/model_unquant.tflite');
      print("Model loaded");
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
      classifyImage();
    }
  }

  Uint8List imageToByteListFloat32(img.Image image) {
    var convertedBytes = Uint8List(4 * 224 * 224 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < 224; i++) {
      for (var j = 0; j < 224; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) / 255.0);
        buffer[pixelIndex++] = (img.getGreen(pixel) / 255.0);
        buffer[pixelIndex++] = (img.getBlue(pixel) / 255.0);
      }
    }
    return convertedBytes;
  }

  Future<void> classifyImage() async {
    if (_image != null && interpreter != null) {
      try {
        var imageBytes = await File(_image!.path).readAsBytes();
        var image = img.decodeImage(imageBytes);
        if (image != null) {
          var resizedImage = img.copyResize(image, width: 224, height: 224);
          var input = imageToByteListFloat32(resizedImage);
          var output = List.filled(1 * 12, 0).reshape([1, 12]);

          interpreter!.run(input, output);

          setState(() {
            _classificationResults = output[0].asMap().entries.map((e) {
              return '${labels[e.key]}: ${(e.value * 100).toStringAsFixed(2)}%';
            }).toList();
          });
        } else {
          print("Problem with decoding the image");
        }
      } catch (e) {
        print('Error during image classification: $e');
      }
    } else {
      print('Interpreter not initialized or no image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        if (_image != null)
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 0, 25, 46),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _image!,
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          SizedBox(
            height: 10,
          ),
        Text('No image selected.'),
        _classificationResults == null
            ? Text('No results yet.')
            : Container(
                height: 180,
                width: 300,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 252, 220, 201),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$_classificationResults',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                )),
        SizedBox(
          height: 10,
        ),
        Center(
          child: ElevatedButton(
            onPressed: isModelLoaded ? pickImage : null,
            child: Text('Pick Image'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 40),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
