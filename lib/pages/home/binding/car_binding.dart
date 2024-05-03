


import 'dart:math';

import 'package:get/get.dart';
import 'package:moharrek/pages/home/model/bidding.dart';
import 'package:moharrek/pages/home/model/car.dart';

import '../controller/carController.dart';

class CarBinding extends Bindings {
  @override
  void dependencies() {
    String cardId = 'carId${Random.secure().nextInt(10)}';
    Get.lazyPut(() => CarController());
    // Get.lazyPut(() => CarController()..addCar(Car(
    //     carId: cardId,
    //     model: 'model'
    //     , make: 'make',
    //     year: 2034,
    //     seller: 'seller',
    //     sellerId: '0987654321qweueu',
    //     type: Type.AUCTION,
    //     price: 10000,
    //     location: 'location',
    //     mileage: 10,
    //     uploadDate: 'uploadDate',
    //     image: 'image', auctions: [
    //       Auction(carId: cardId,participantId: 'participantId', participantName: 'Beshr Qashar', amount: 500, date: 'date', expiryDate: DateTime.now())
    // ])),fenix: true);
  }
}