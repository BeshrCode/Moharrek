import 'package:flutter/material.dart';
import 'package:moharrek/car_widget.dart';
import 'package:moharrek/components/Button.dart';

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({super.key});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  int imageNum = 0;
  List<Widget> carImage = [
    Image.asset("images/car_card/blue_car.jpg"),
    Image.asset("images/red_car.png"),
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
          CustomCarDetailHeder(
              carName: "تويوتا كامري 2023",
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
          CustomCarDetailCard(
              model: "كامري",
              manufacturer: "تويوتا",
              year: 2023,
              color: "ازرق",
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
          CustomCarDesc(
            desc: "بدون رش فل كامل مفحوصة مجددة، الرجاء عدم التواصل لغير الجاد",
          ),
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
                    carName: "كامري تيوتا",
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
                    carName: "كامري تويوتا",
                    year: 2020,
                    seller: "mohammed",
                    isNew: false,
                    price: 23000,
                    location: "مكة",
                    mileage: 45000,
                    uploadDate: "3 ايام",
                    image: "images/red_car.png"),
                SizedBox(
                  width: 20,
                ),
                CustomVerticalCarCard(
                    carName: "كامري تيوتا",
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
    ;
  }
}
