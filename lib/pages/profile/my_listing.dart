import 'package:flutter/material.dart';
import 'package:moharrek/widget/home_widget.dart';
import 'package:moharrek/pages/profile/add_car_page.dart';

class MyListingPage extends StatefulWidget {
  const MyListingPage({super.key});

  @override
  State<MyListingPage> createState() => _MyListingPageState();
}

class _MyListingPageState extends State<MyListingPage> {
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
            "إعلاناتي",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
          child: ListView(
            children: [
              MyListingCarCard(
                  model: "كامري",
                  make: "تويوتا",
                  year: 2023,
                  uploadDate: "قبل اسبوع",
                  image: "images/car_card/blue_car.jpg"),
              SizedBox(
                height: 20,
              ),
              MyListingCarCard(
                  model: "كامري",
                  make: "تويوتا",
                  year: 2023,
                  uploadDate: "قبل اسبوع",
                  image: "images/car_2.jpg"),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
