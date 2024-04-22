import 'package:flutter/material.dart';
import 'package:moharrek/widget/home_widget.dart';
import 'package:moharrek/components/button.dart';

class UsedCarDetailsPage extends StatefulWidget {
  const UsedCarDetailsPage({super.key});

  @override
  State<UsedCarDetailsPage> createState() => _UsedCarDetailsPageState();
}

class _UsedCarDetailsPageState extends State<UsedCarDetailsPage> {
  int imageNum = 0;
  List<Widget> carImage = [
    Image.asset("images/car_card/blue_car.jpg"),
    Image.asset("images/car_2.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Title'),
          ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SizedBox(
            height: 5,
          ),
          UsedCarDetailHeder(
              model: "كامري",
              make: "تويوتا",
              year: 2023,
              carPrice: 45000,
              carLocation: "مكة المكرمة",
              uploadDate: "قبل ثلاثة ايام",
              carImage: carImage),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: CustomeButtonIcon(
              text: "تواصل مع البائع",
              textColor: Colors.white,
              buttonColor: Colors.blue,
              onPressed: () {},
              isLoading: false,
              width: 30,
              icon: Icons.call,
              iconColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "خصائص السيارة",
            style: TextStyle(
                fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          UsedCarDetailCard(
              model: "كامري",
              make: "تويوتا",
              year: 2023,
              mileage: 45000,
              isManualGear: false),
          SizedBox(
            height: 20,
          ),
          Text(
            "الوصف",
            style: TextStyle(
                fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          CarDesc(desc: "مفحوصة ومجددة فل كامل"),
          SizedBox(
            height: 20,
          ),
          Text(
            "مقترحة",
            style: TextStyle(
                fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 290,
            child: ListView(
              // shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                CustomVerticalCarCard(
                    model: "كامري",
                    make: "تويوتا",
                    year: 2020,
                    seller: "mohammed",
                    isNew: false,
                    price: 23000,
                    location: "مكة",
                    mileage: 45000,
                    uploadDate: "3 ايام",
                    image: "images/car_card/blue_car.jpg"),
                SizedBox(
                  width: 20,
                ),
                CustomVerticalCarCard(
                    model: "كامري",
                    make: "تويوتا",
                    year: 2020,
                    seller: "mohammed",
                    isNew: false,
                    price: 23000,
                    location: "مكة",
                    mileage: 45000,
                    uploadDate: "3 ايام",
                    image: "images/car_2.jpg"),
                SizedBox(
                  width: 20,
                ),
                CustomVerticalCarCard(
                    model: "كامري",
                    make: "تويوتا",
                    year: 2020,
                    seller: "mohammed",
                    isNew: false,
                    price: 23000,
                    location: "مكة",
                    mileage: 45000,
                    uploadDate: "3 ايام",
                    image: "images/car_card/blue_car.jpg"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
