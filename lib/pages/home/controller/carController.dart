import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage; // Add this import
import 'package:moharrek/shared_pref.dart';
import '../model/bidding.dart';

class CarController extends GetxController {
  final CollectionReference _carsCollection =
  FirebaseFirestore.instance.collection('cars');

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxDouble progress = RxDouble(0);
  final RxString currentOp = RxString('');
  Rx<List<File>> imageList = Rx(RxList.empty());
  Rx<File> periodicInspection = Rx(File(''));
  RxString? selectedManufacturer = RxString('تويوتا');
  RxString? searchText = RxString('');
  RxInt selectedBrand = RxInt(0);
  RxInt selectedChildBrand = RxInt(0);
  RxInt newSelectedBrand = RxInt(0);
  RxString selectedCity = ''.obs;
  RxString newSelectedCity = 'الكل'.obs;
  RxString usedSelectedCity = 'الكل'.obs;
  RxDouble initAuctionPrice = RxDouble(100);
  RxDouble limitAuctionPrice = RxDouble(0);
  RxDouble price = RxDouble(0);
  RxList<Car> newCars = List<Car>.empty().obs;
  RxList<Car> usedCars = List<Car>.empty().obs;

  List<String> cites = [
    "الكل",
    "الرياض", // Riyadh
    "جدة", // Jeddah
    "مكة المكرمة", // Mecca
    "المدينة المنورة", // Medina
    "الدمام", // Dammam
    "الخبر", // Khobar
    "الطائف", ];
  List<String> brands = ['الكل','تويوتا','فورد','بي إم دبليو','هوندا','نيسان'];
  List<String> manufacturers = [
    "تويوتا",
    "نيسان",
    "فورد",
    "بي إم دبليو",
  ];

  Map<String,List<String>> models = {
    "تويوتا": ['كامري', 'كورولا', 'راف فور', 'هايلاندر'],
    "نيسان": ['ألتيما', 'ماكسيما', 'روغ', 'باثفايندر'],
    "فورد": ['فورد إف-150', 'فورد موستانغ', 'فورد إكسبلورر', 'فورد اسكيب'],
    "بي إم دبليو": ['بي إم دبليو الفئة 3', 'بي إم دبليو الفئة 5', 'بي إم دبليو إكس5', 'بي إم دبليو i8']
  };


  Future<void> updateAvailable(String carId, bool newAvailability) async {
    try {
      isLoading.value = true;
      await _carsCollection.doc(carId).update({'available': newAvailability,'expireDate': DateTime.now().add(const Duration(days: 14)).toString()});
      isLoading.value = false;
    } catch (e) {
      error.value = 'Error updating car availability: $e';
      isLoading.value = false;
    }
  }
  Stream<List<Car>> getCarsStream() {
    try {
      return _carsCollection.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error fetching cars: $e');
      return Stream.error('Error fetching cars: $e');
    }
  }
  Stream<List<Car>> getMyCarsStream() {
    try {
      return _carsCollection
          .where('sellerId', isEqualTo: Preference.shared.getUserId()) // Filter cars by sellerId
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error fetching cars: $e');
      return Stream.error('Error fetching cars: $e');
    }
  }


  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];
    try {
      isLoading(true);
      for (int i = 0; i < images.length; i++) {
        File image = images[i];
        String imagePath = 'images/${DateTime.now().millisecondsSinceEpoch}_$i.png'; // Unique path for each image
        firebase_storage.UploadTask uploadTask = firebase_storage
            .FirebaseStorage.instance
            .ref(imagePath)
            .putFile(image);

        // Track upload progress
        uploadTask.snapshotEvents.listen((event) {
          progress.value =
              event.bytesTransferred / event.totalBytes.toDouble();
          currentOp('Image $i upload progress: ${progress}');

          print('Image $i upload progress: $progress');
        });

        // Wait for upload to complete and get download URL
        firebase_storage.TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Add download URL to the list
        imageUrls.add(downloadURL);
      }
    } catch (e) {
      isLoading(false);
      print('Error uploading images: $e');
      throw e;
    }

    return imageUrls;
  }
  Future<String> uploadPdf(File pdfFile) async {
    try {

      String pdfPath = 'pdfs/${DateTime.now().millisecondsSinceEpoch}.pdf'; // Unique path for the PDF file
      firebase_storage.UploadTask uploadTask = firebase_storage
          .FirebaseStorage.instance
          .ref(pdfPath)
          .putFile(pdfFile);

      // Track upload progress
      uploadTask.snapshotEvents.listen((event) {
        progress.value = event.bytesTransferred / event.totalBytes.toDouble();
        currentOp('PDF upload progress: $progress');
        print('PDF upload progress: $progress');
      });

      // Wait for upload to complete and get download URL
      firebase_storage.TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      isLoading(false);
      print('Error uploading PDF: $e');
      throw e;
    }
  }
  Stream<Car> getCarByIdStream(Car car) {
    try {
      return _carsCollection.doc(car.carId).snapshots().map((snapshot) {
        if (snapshot.exists) {
          return Car.fromJson(snapshot.data() as Map<String, dynamic>);
        } else {
          // If the document doesn't exist, return null
          return car;
        }
      });
    } catch (e) {
      print('Error fetching car by ID: $e');
      throw e;
    }
  }
  Future<void> addCar(Car car) async {
    try {
      car.images = await uploadImages(imageList.value);
      car.uploadDate = await uploadPdf(periodicInspection.value);
      currentOp('Adding Car Data');
      await _carsCollection.doc(car.carId).set(car.toJson());
      isLoading(false);
      periodicInspection(File(''));
      imageList.value.clear();
    } catch (e) {
      error.value = 'Error adding car: $e';
      isLoading.value = false;
    }
  }
  Future<void> deleteCar(String carId) async {
    try {
      isLoading.value = true;
      await _carsCollection.doc(carId).delete();
      isLoading.value = false;
    } catch (e) {
      error.value = 'Error deleting car: $e';
      isLoading.value = false;
    }
  }
  Future<void> updateCar(
      String carId, Map<String, dynamic> updatedData) async {
    try {
      isLoading.value = true;
      await _carsCollection.doc(carId).update(updatedData);
      isLoading.value = false;
    } catch (e) {
      error.value = 'Error updating car: $e';
      isLoading.value = false;
    }
  }
  Stream<List<Car>> getCarsByTypeAndCity(Type type, {String? city, String? brand}) {
    try {
      return _carsCollection.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .where((car) {
        // Filter by type
        if (car.type != type) return false;
        // Filter by city if provided
        if (city != null && city.isNotEmpty && car.location != city) return false;
        // Filter by brand if provided
        if (brand != null && brand.isNotEmpty && brand != 'الكل' && car.make != brand) return false;
        return true;
      })
          .toList());
    } catch (e) {
      print('Error fetching cars: $e');
      throw e;
    }
  }


  Stream<List<Car>> getCarsByType(Type type) {
    if(type == Type.AUCTION){
      return _carsCollection
          .where('type', isEqualTo: type.name)
          .where('available', isEqualTo: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    }else{
      return _carsCollection
          .where('type', isEqualTo: type.name)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    }

  }
  Stream<List<Car>> getCarsUnAvailable() {
      return _carsCollection
          .where('type', isEqualTo: Type.AUCTION.name)
          .where('available', isEqualTo: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    }

  Future<void> addAuction(Auction auction) async {
    try {
      isLoading.value = true;

      // Fetch the car from Firestore
      DocumentSnapshot carSnapshot = await _carsCollection.doc(auction.carId).get();

      // Check if the car exists
      if (carSnapshot.exists) {
        // Deserialize the car data
        Car car = Car.fromJson(carSnapshot.data() as Map<String, dynamic>);

        // Add the auction to the car
        car.addAuction(auction);

        // Update the car document in Firestore
        await _carsCollection.doc(auction.carId).update(car.toJson());
        isLoading.value = false;

      } else {
        // Car not found
        error.value = 'Car with ID $auction.carId not found';
        isLoading.value = false;

        print('Car with ID $auction.carId not found');
      }
    } catch (e) {
      // Handle errors
      error.value = 'Error adding bidding: $e';
      isLoading.value = false;

      print('Error adding auction to car: $e');
    }
  }
  Future<void> removeAuctionFromCar(String carId, String participantId) async {
    try {
      // Fetch the car from Firestore
      DocumentSnapshot carSnapshot = await _carsCollection.doc(carId).get();

      // Check if the car exists
      if (carSnapshot.exists) {
        // Deserialize the car data
        Car car = Car.fromJson(carSnapshot.data() as Map<String, dynamic>);

        // Remove the auction from the car
        car.removeAuctionByParticipantId(participantId);

        // Update the car document in Firestore
        await _carsCollection.doc(carId).update(car.toJson());
      } else {
        // Car not found
        print('Car with ID $carId not found');
      }
    } catch (e) {
      // Handle errors
      print('Error removing auction from car: $e');
    }
  }
  List<String> filesToBase64(List<File> files) {
    return files.map((file) {
      List<int> fileBytes = file.readAsBytesSync();
      String base64Image = base64Encode(fileBytes);
      return base64Image;
    }).toList();
  }

// Convert a list of base64 encoded strings to a list of File objects
  List<File> base64ToFiles(List<String> base64Strings) {
    return base64Strings.map((base64String) {
      List<int> bytes = base64Decode(base64String);
      String tempPath = '${DateTime.now().millisecondsSinceEpoch}.png'; // Example: You might want to provide a proper file extension
      File file = File(tempPath);
      file.writeAsBytesSync(bytes);
      return file;
    }).toList();
  }
  addImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick multiple images.
    final List<XFile> images = await picker.pickMultiImage();

    if (images != null) {
      // Convert selected images to File objects and store them in the imageList.
      imageList(images.map((image) => File(image.path)).toList());
      // setState(() {});
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    // Check for platform support
    if (!await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber))) {
      throw 'Could not launch ${Uri(scheme: 'tel', path: phoneNumber)}';
    } else {
      await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
    }
  }

  addPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      periodicInspection!(File(result.files.single.path!));
    } else {
      // User canceled the picker
    }
    // setState(() {});
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Stream<List<Car>> getCarsByTypeAndCityStream(Type type, {String? city}) {
    try {
      Query query = _carsCollection.where('type', isEqualTo: (type.name));

      // Add city filter if provided
      if (city != null && city.isNotEmpty) {
        query = query.where('location', isEqualTo: city);
      }

      return query.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => Car.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error fetching cars: $e');
      throw e;
    }
  }

  void selectBrand(int index) {
    selectedBrand(index);
  }
  void selectBrandChild(int index) {
    selectedChildBrand(index);
  }
  void selectNewBrand(int index) {
    newSelectedBrand(index);
  }
  void selectNewCity(String city) {
    newSelectedCity(city);
  }
  void selectUsedCity(String city) {
    usedSelectedCity(city);
  }
}
