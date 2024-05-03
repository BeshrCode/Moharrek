import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../components/brand_widget.dart';
import '../../components/dropdown_menu_button.dart';
import '../../widget/home_widget.dart';
import 'controller/carController.dart';
import 'model/car.dart';

class UsedCarTabBarView extends GetWidget<CarController> {
  const UsedCarTabBarView({super.key});


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomDropdownMenuButton(
            hint: 'المدينة',
            list: controller.cites,
            onChanged: (city) {
              controller.selectUsedCity(city);
            },
            hintSearch: 'أختر المدينة'),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: const Text(
            "الشركات",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: 40,
          // color: Colors.amber,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.brands.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.white,
                onTap: () {
                  controller.selectBrand(index);
                },
                child: BrandWidget(controller: controller, index: index),
              );
            },
          ),
        ),
        Container(
          child: const Text(
            "استكشف",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Car>>(
                stream: controller.getCarsByType(Type.USED),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Obx(() {
                      final filteredCars = snapshot.data!.where((element) {
                        final String searchText = controller.searchText!.value.toLowerCase();
                        final String selectedCity = controller.usedSelectedCity.value;
                        final String selectedBrand = controller.brands[controller.selectedBrand.value];

                        // Check if the selected city is "الكل" or matches the car's location
                        final bool cityMatch = selectedCity == 'الكل' || element.location == selectedCity;

                        // Check if the selected brand is "الكل" or matches the car's company
                        final bool brandMatch = selectedBrand == 'الكل' || selectedBrand == element.company;

                        // Check if the car's details contain the searchText
                        final bool textMatch = element.model.toLowerCase().contains(searchText) ||
                            element.make.toLowerCase().contains(searchText) ||
                            element.location.toLowerCase().contains(searchText);

                        // Return true if either the city, brand, or searchText matches
                        return cityMatch && brandMatch && textMatch;
                      });

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCars.toList().length, // Convert to list for indexing
                        itemBuilder: (context, index) {
                          Car car = filteredCars.toList()[index]; // Access element by index in list

                          return Column(
                            children: [
                              CustomUsedCarCard(car: car),
                              const SizedBox(
                                height: 15,
                              )
                            ],
                          );
                        },
                      );
                    });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        )

        // BottomNavigationBar(items: items)
      ],
    );
  }


}