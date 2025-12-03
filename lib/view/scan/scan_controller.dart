import 'dart:io';

import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:developer';
import 'dart:typed_data';

class ScanController extends GetxController {
  // File? _pickedImage;
  final ImagePicker _imagePicker = ImagePicker();
  ImagePicker get imagePicker => _imagePicker;

  // String? imagePath;
  // img.Image? image;
  // Map<String, double>? classification;
  File? _imageFile;
  File? get imageFile => _imageFile;

  Interpreter? _interpreter;
  Map<String, dynamic>? _predictionDetails;
  Map<String, dynamic>? get predictionDetails => _predictionDetails;

  bool cameraIsAvailable = Platform.isAndroid || Platform.isIOS;
  String percentage = '', name = '';

  @override
  void onInit() {
    loadModel();

    super.onInit();
  }

  Uint8List preprocessImage(img.Image image) {
    // Resize the image to 224x224
    final resizedImage = img.copyResize(image, width: 224, height: 224);

    // Preprocess the resized image
    final int width = resizedImage.width;
    final int height = resizedImage.height;
    final inputArray = Float32List(width * height * 3);
    print(height);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final pixelIndex = (y * width + x) * 3;
        final pixel = resizedImage.getPixel(x, y);
        inputArray[pixelIndex] = pixel.r / 255.0;
        inputArray[pixelIndex + 1] = pixel.g / 255.0;
        inputArray[pixelIndex + 2] = pixel.b / 255.0;
      }
    }

    return inputArray.buffer.asUint8List();
  }

  Future<void> performInference(File imageFile) async {
    if (_interpreter == null) return;

    // Read the image file and convert it to an image
    final image = img.decodeImage(await imageFile.readAsBytes());

    // Preprocess the image and convert it to a NumPy array
    final preprocessedImage = preprocessImage(image!);

    // Run inference on the model
    final outputBuffer =
        Float32List(3 * 1); // Create output buffer with correct shape [3, 1]

    // Reshape the output buffer to match the expected shape [1, 3]
    final reshapedOutputBuffer = outputBuffer.reshape([1, 3]);

    _interpreter!
        .run(preprocessedImage.buffer.asUint8List(), reshapedOutputBuffer);

    // Find the index with the highest probability
    int maxIndex = 0;
    double maxProbability = 0.0;
    for (int i = 0; i < 3; i++) {
      if (reshapedOutputBuffer[0][i] > maxProbability) {
        maxIndex = i;
        maxProbability = reshapedOutputBuffer[0][i];
      }
    }

    // Map index to label
    String predictionLabel = '';
    switch (maxIndex) {
      case 0:
        predictionLabel = 'Basal Cell Carcinoma (Cancer)';
        break;
      case 1:
        predictionLabel = 'Nevus (Non-Cancerous)';
        break;
      case 2:
        predictionLabel = 'Melanoma (Cancer)';
        break;
    }

    _predictionDetails = {
      'predictionPercentage': (maxProbability * 100).toStringAsFixed(2),
      'predictionLabel': predictionLabel,
    };
    update();
  }

  Future<void> loadModel() async {
    final interpreterOptions = InterpreterOptions();
    // Add any interpreter options if needed

    // Load the model from assets
    _interpreter = await Interpreter.fromAsset(
      'assets/model/tf_lite_LessionLabModel.tflite',
      options: interpreterOptions,
    );
  }

  Future<void> getImageAndPredict(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _predictionDetails = null; // Clear previous prediction details
      update();

      // Perform inference with the selected image
      await performInference(_imageFile!);
      log('Performed inference'); // Log that inference was performed
    }
  }

  void cleanResult() {
    // imagePath = null;
    // image = null;
    update();
  }

  // Future<void> processImage() async {
  //   if (imagePath != null) {
  //     // Read image bytes from file
  //     final imageData = File(imagePath!).readAsBytesSync();

  //     // Decode image using package:image/image.dart (https://pub.dev/image)
  //     image = img.decodeImage(imageData);
  //   }
  // }
  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }
}
