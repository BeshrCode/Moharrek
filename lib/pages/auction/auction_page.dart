import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:moharrek/widget/auction_widget.dart';

import '../../app_pages.dart';
import '../auth/controller/auth_controller.dart';
import '../auth/model/user.dart';

class AuctionPage extends GetWidget<CarController> {
  const AuctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: StreamBuilder<UserData?>(
          stream: Get.find<AuthController>().getUserDataStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading indicator while data is being fetched
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot
                  .error}'); // Show an error message if an error occurred
            } else if (snapshot.hasData && snapshot.data != null) {
              // If user data is available, show the floating action button
              return FloatingActionButton(
                onPressed: () {
                  Get.toNamed(AppPages.addCarPage,arguments: Type.AUCTION);
                },
                child: const Icon(Icons.add),
              );
            } else {
              // If user data is not available, hide the floating action button
              return const SizedBox(); // Return an empty SizedBox to hide the floating action button
            }
          },
        ),
        appBar: AppBar(
            // title: Text('المزاد'),
            ),
        body: StreamBuilder<List<Car>>(
          stream: controller.getCarsByType(Type.AUCTION),
          builder: (context, snapshot) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20,);
              },
              itemCount: snapshot.data?.length ??0,
              itemBuilder: (context, index) {
                
                return CustomAuctionCarCard(car: snapshot.data![index]);
              },
              padding: const EdgeInsets.symmetric(horizontal: 30),

            );
          }
        ));
  }
}
