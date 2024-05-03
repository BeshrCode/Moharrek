import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/components/brand_widget.dart';
import 'package:moharrek/components/dropdown_menu_button.dart';
import 'package:moharrek/pages/auth/model/user.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:moharrek/pages/home/used_cars_page.dart';
import 'package:moharrek/widget/home_widget.dart';
import 'package:pinput/pinput.dart';

import '../auth/controller/auth_controller.dart';
import 'new_cars_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  String? searchValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }



  List<Map<dynamic, dynamic>> searchedInUsedCars = [];
  List<Map<dynamic, dynamic>> searchedInNewCars = [];
  List<Map<dynamic, dynamic>> selectedCars = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

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
          } else if (snapshot.hasData && snapshot.data != null &&
              snapshot.data!.admin) {
            // If user data is available, show the floating action button
            return FloatingActionButton(
              onPressed: () {
                Get.toNamed(AppPages.addCarPage,arguments:tabController!.index==0? Type.USED:Type.NEW);
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
          title: CupertinoSearchTextField(
            backgroundColor: Colors.white,
            placeholder: "بحث...",
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            onChanged: (value) {
              print(value);
              Get.find<CarController>().searchText!(value);

            },
          ),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 0),
            indicatorWeight: 4,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontFamily: "NotoKufiArabic",
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: "أفراد",
              ),
              Tab(
                text: "معارض",
              ),
            ],
          )),
      body: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: TabBarView(
          controller: tabController,
          children: const[
            UsedCarTabBarView(),
            NewCarTabView()
          ],
        ),
      ),
    );
  }
}



