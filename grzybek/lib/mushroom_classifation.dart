import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ClassifierScreen extends StatefulWidget {
  @override
  _ClassifierScreenState createState() => _ClassifierScreenState();
}

class _ClassifierScreenState extends State<ClassifierScreen> {
  File? _image;
  List<dynamic>? _classificationResults;
  late Interpreter interpreter;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/model.tflite');
      print("Załadowano model");
    } catch (e) {
      print("Błąd ładowania modelu: $e");
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

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(inputSize * inputSize * 3);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        convertedBytes[pixelIndex++] = img.getRed(pixel);
        convertedBytes[pixelIndex++] = img.getGreen(pixel);
        convertedBytes[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes;
  }

  Future<void> classifyImage() async {
    if (_image != null) {
      try {
        var imageBytes = await File(_image!.path).readAsBytes();
        var image = img.decodeImage(imageBytes);
        if (image != null) {
          var resizedImage = img.copyResize(image, width: 224, height: 224);

          // Przekształcenie obrazu do formatu akceptowanego przez model
          var input = imageToByteListUint8(resizedImage, 224);
          var output = List.filled(1 * 8, 0)
              .reshape([1, 8]); // Zaktualizowany rozmiar tensora wyjściowego

          // Uruchomienie modelu
          interpreter.run(input, output);

          // Aktualizacja UI
          setState(() {
            _classificationResults = output;
          });
        } else {
          print("Problem with decoding the image");
        }
      } catch (e) {
        print('Error during image classification: $e');
      }
    }
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Uint8List(4 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mushroom Classifier')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _image == null ? Text('No image selected.') : Image.file(_image!),
          ElevatedButton(
            onPressed: pickImage,
            child: Text('Pick Image'),
          ),
          _classificationResults == null
              ? Text('No results yet.')
              : Text('Results: $_classificationResults'),
        ],
      ),
    );
  }
}
