import 'package:flutter/material.dart';
import 'package:moharrek/car_widget.dart';
import 'package:moharrek/pages/add_car_page.dart';

class MyCarPage extends StatefulWidget {
  const MyCarPage({super.key});

  @override
  State<MyCarPage> createState() => _MyCarPageState();
}

class _MyCarPageState extends State<MyCarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddCarPage()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(
            "مركباتي",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
          child: ListView(
            children: [
              MyListingCarCard(
                  carName: "تويوتا كامري",
                  year: 2023,
                  uploadDate: "قبل اسبوع",
                  image: "images/car_card/blue_car.jpg")
            ],
          ),
        ));
  }
}
