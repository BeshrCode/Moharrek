import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:moharrek/pages/home/controller/carController.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key, required this.index, required this.controller});

  final int index;
  final CarController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: 70,
        decoration: BoxDecoration(
            color: controller.selectedBrand == index ? Colors.blue : Colors
                .grey[400], borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "${controller.brands[index]}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }

}
