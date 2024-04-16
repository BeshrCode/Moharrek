import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moharrek/car_widget.dart';
import 'package:moharrek/pages/profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  // List brands = [
  //   "Toyota",
  //   "Ford",
  //   "BMW",
  //   "Honda",
  //   "Nissan",
  // ];
  List brandsCateg = [
    {"brand": "الكل", "categColorIcon": Colors.blue},
    {"brand": "Toyota", "categColorIcon": Colors.grey[300]},
    {"brand": "Ford", "categColorIcon": Colors.grey[300]},
    {"brand": "BMW", "categColorIcon": Colors.grey[300]},
    {"brand": "Honda", "categColorIcon": Colors.grey[300]},
    {"brand": "Nissan", "categColorIcon": Colors.grey[300]},
  ];

  colorizeCateg(int index) {
    for (int i = 0; i < brandsCateg.length; i++) {
      if (i == index) {
        brandsCateg[i]["categColorIcon"] = Colors.blue;
      } else {
        brandsCateg[i]["categColorIcon"] = Colors.grey[300];
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30, left: 10, right: 10, top: 10),
              child: InkWell(
                  onTap: () => showSearch(
                        context: context,
                        delegate: CustomSearch(hintText: ""),
                      ),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(
                            width: 10,
                          ),
                          Text("البحث..."),
                        ],
                      ))),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "الشركات",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              height: 40,
              // color: Colors.amber,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brandsCateg.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print(index);
                      colorizeCateg(index);
                      setState(() {});
                    },
                    child: CustomCategories(brandsCateg[index]["brand"],
                        brandsCateg[index]["categColorIcon"]),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "استكشف",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            // Image.asset("images/Car_card.jpg"),

            SizedBox(
              height: 10,
            ),
            CustomCarCard(
                carName: "كامري تيوتا",
                Year: 2020,
                seller: "mohammed",
                isNew: true,
                price: 23000,
                location: "مكة",
                mileage: 45000,
                uploadDate: "3 ايام",
                image: "images/red_car.png"),
            SizedBox(
              height: 10,
            ),
            CustomCarCard(
                carName: "كامري تيوتا",
                Year: 2020,
                seller: "mohammed",
                isNew: false,
                price: 23000,
                location: "مكة",
                mileage: 45000,
                uploadDate: "3 ايام",
                image: "images/car_card/blue_car.jpg"),
            SizedBox(
              height: 10,
            ),
            CustomCarCard(
                carName: "كامري تيوتا",
                Year: 2020,
                seller: "mohammed",
                isNew: false,
                price: 23000,
                location: "مكة",
                mileage: 45000,
                uploadDate: "3 ايام",
                image: "images/car_card/blue_car.jpg"),
            SizedBox(
              height: 10,
            ),
            CustomCarCard(
                carName: "كامري تيوتا",
                Year: 2020,
                seller: "mohammed",
                isNew: false,
                price: 23000,
                location: "مكة",
                mileage: 45000,
                uploadDate: "3 ايام",
                image: "images/car_card/blue_car.jpg"),

            // BottomNavigationBar(items: items)
          ],
        ),
      ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  CustomSearch({
    required String hintText,
  }) : super(
            searchFieldLabel: hintText,
            searchFieldStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal));
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.close))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // IconButton(onPressed: () {}, icon: Icon(Icons.close));/
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Result");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("Content");
  }
}

class CustomCategories extends StatelessWidget {
  final String? text;
  final Color? cateColor;
  const CustomCategories(this.text, this.cateColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      // height: 100,
      width: 70,

      // height: 100,
      child: Center(
        child: Text(
          "$text",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: BoxDecoration(
          color: cateColor, borderRadius: BorderRadius.circular(10)),
    );
  }
}
