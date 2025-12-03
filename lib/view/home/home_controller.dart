import 'package:get/get.dart';
import 'package:lessionlab/data/network/firebase/firebase_services.dart';
import 'package:lessionlab/models/scan_model.dart';

class HomeController extends GetxController {
  String? userName;

  List<ScanDetails> scanDetailsList = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Fetch user name and scan details when the widget is initialized
    FirebaseFirestoreService.fetchUserData();
    FirebaseFirestoreService.fetchScanDetails();
  }
}
