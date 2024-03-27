import 'package:flutter/material.dart';

class CarPrimarySpecific extends StatelessWidget {
  final String text;
  final String image;
  const CarPrimarySpecific(
      {super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 30,
          height: 30,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "$text",
          style: TextStyle(
              fontSize: 12,
              fontFamily: "NotoNaskhArabic",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CustomCarCard extends StatefulWidget {
  final String carName;
  final int Year;
  final String seller;
  final bool isNew;
  final double price;
  final String location;
  final int mileage;
  final String uploadDate;
  final String image;
  const CustomCarCard(
      {super.key,
      required this.carName,
      required this.Year,
      required this.seller,
      required this.isNew,
      required this.price,
      required this.location,
      required this.mileage,
      required this.uploadDate,
      required this.image});

  @override
  State<CustomCarCard> createState() => _CustomCarCardState();
}

class _CustomCarCardState extends State<CustomCarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        // color: Colors.grey[200],
        decoration: BoxDecoration(
            color: Colors.blue[100],
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 3),
              width: 120,
              height: double.infinity,
              // color: Colors.red,
              child: Image.asset(
                "${widget.image}",
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                // width: 200,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.carName}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: 50,
                                height: 18,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Center(
                                  child: widget.isNew
                                      ? Text("جديد",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Rubik",
                                              fontWeight: FontWeight.bold))
                                      : Text("مستعمل",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Rubik",
                                              fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " السنة: ${widget.Year}",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "البائع : ${widget.seller}",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CarPrimarySpecific(
                          image: "images/car_card/dollar.png",
                          text: "${widget.price}",
                        ),
                        CarPrimarySpecific(
                          image: "images/car_card/location.png",
                          text: "${widget.location}",
                        ),
                        CarPrimarySpecific(
                          image: "images/car_card/speedometer.png",
                          text: "${widget.mileage}",
                        ),
                        CarPrimarySpecific(
                          image: "images/car_card/upload.png",
                          text: "${widget.uploadDate}",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
