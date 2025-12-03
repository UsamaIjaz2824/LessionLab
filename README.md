# Lesson Lab – Skin Cancer Classification (MobileNetV2 + TFLite + Flutter)

Lesson Lab is a deep-learning powered skin cancer detection system that classifies skin lesions into **Melanoma**, **Basal Cell Carcinoma**, and **Nevus**.  
A fine-tuned **MobileNetV2** model is trained on dermatology images and exported to **TensorFlow Lite**, enabling fast, offline, on-device inference inside a fully developed **Flutter mobile application**.

---

## 🚀 Features

- 📱 Cross-platform Flutter mobile application  
- 🧠 MobileNetV2-based skin cancer classifier  
- 🔍 Classifies three types of lesions:
  - **Melanoma**
  - **Basal Cell Carcinoma (BCC)**
  - **Nevus**
- ⚡ TensorFlow Lite inference for offline predictions  
- 🎨 Modern UI with clean navigation, splash, scan, history, and get-started screens  
- 🔥 Firebase-ready setup (optional authentication/storage)  
- 🧩 MVVM architecture in Flutter (view → view_model → models)

---

## 🧠 Machine Learning Model

The model is trained using Transfer Learning on **MobileNetV2**, optimized for mobile deployment.

### Model Files (Training Side)
DATA2000/code/
│── Labels.txt
│── model_v3.h5 # Trained Keras model
│── tf_lite_LessionLabModel.tflite # Exported TFLite model
│── Lession Lab.ipynb # Main training notebook
│── LesionLab_V2.ipynb # V2 improved model
│── LLab.ipynb
│── LLV42000.ipynb

### Training Pipeline
1. Import dermatology dataset (3 classes)  
2. Preprocess images (resize, normalize, augmentation)  
3. Load MobileNetV2 (transfer learning)  
4. Freeze base layers & add custom classifier  
5. Train on dataset → evaluate accuracy  
6. Export final `.h5` model  
7. Convert to `.tflite` for deployment  

### TFLite Conversion
Conversion similar to:

```python
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("tf_lite_LessionLabModel.tflite", "wb") as f:
    f.write(tflite_model)
LessionLabs/
│── assets/
│   ├── banner/
│   ├── detect/
│   ├── images/
│   └── model/
│       ├── Labels.txt
│       └── tf_lite_LessionLabModel.tflite
│
│── lib/
│   ├── data/
│   ├── helper/
│   │   ├── image_classification_helper.dart
│   │   ├── isolate_inference.dart
│   │   └── model_integration.dart
│   ├── models/
│   ├── res/
│   ├── utils/
│   └── view/
│       ├── auth/
│       ├── get_started/
│       ├── history/
│       ├── home/
│       ├── scan/
│       └── splash/
│
│── firebase.json
│── firebase_options.dart
│── pubspec.yaml
