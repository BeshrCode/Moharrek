import 'package:flutter/material.dart';
import 'package:moharrek/components/button.dart';
import 'package:moharrek/pages/home/car_details_page.dart';

class CarPrimarySpecific extends StatelessWidget {
  final String text;
  final String image;
  final double? imageWidth;
  final double? imageHeight;
  const CarPrimarySpecific(
      {super.key,
      required this.text,
      required this.image,
      this.imageHeight,
      this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: imageHeight ?? 30,
          height: imageWidth ?? 30,
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
  final String model;
  final String make;
  final int year;
  final String seller;
  final bool isNew;
  final double price;
  final String location;
  final int mileage;
  final String uploadDate;
  final String image;
  const CustomCarCard(
      {super.key,
      required this.model,
      required this.make,
      required this.year,
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
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CarDetailsPage()));
      },
      child: Container(
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
                                  "${widget.make} ${widget.model}",
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
                              " سنة الصنع: ${widget.year}",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
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
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class MyListingCarCard extends StatefulWidget {
  final String model;
  final String make;
  final int year;

  final String uploadDate;
  final String image;
  const MyListingCarCard(
      {super.key,
      required this.model,
      required this.make,
      required this.year,
      required this.uploadDate,
      required this.image});

  @override
  State<MyListingCarCard> createState() => _MyListingCarCardState();
}

class _MyListingCarCardState extends State<MyListingCarCard> {
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
                // color: Colors.amber,

                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

                // width: 200,
                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.make} ${widget.model}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                " السنة: ${widget.year}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CarPrimarySpecific(
                          image: "images/car_card/upload.png",
                          text: "${widget.uploadDate}",
                          imageHeight: 25,
                          imageWidth: 25,
                        )
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

class CustomVerticalCarCard extends StatefulWidget {
  final String model;
  final String make;
  final int year;
  final String seller;
  final bool isNew;
  final double price;
  final String location;
  final int mileage;
  final String uploadDate;
  final String image;
  const CustomVerticalCarCard(
      {super.key,
      required this.model,
      required this.make,
      required this.year,
      required this.seller,
      required this.isNew,
      required this.price,
      required this.location,
      required this.mileage,
      required this.uploadDate,
      required this.image});

  @override
  State<CustomVerticalCarCard> createState() => _CustomVerticalCarCardState();
}

class _CustomVerticalCarCardState extends State<CustomVerticalCarCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          // height: 120,
          width: 210,
          decoration: BoxDecoration(
              color: Colors.blue[200], borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                top: 15,
                left: 10,
                right: 10,
              ),
              // alignment: Alignment.topCenter,
              color: Colors.grey[200],
              height: 100,
              width: 150,
              child: Image.asset(
                widget.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${widget.make} ${widget.model}",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 50,
              height: 18,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
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
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              " السنة: ${widget.year}",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "البائع : ${widget.seller}",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CarPrimarySpecific(
                  image: "images/car_card/dollar.png",
                  text: "${widget.price}",
                  imageHeight: 25,
                  imageWidth: 25,
                ),
                CarPrimarySpecific(
                  image: "images/car_card/location.png",
                  text: "${widget.location}",
                  imageHeight: 25,
                  imageWidth: 25,
                ),
                CarPrimarySpecific(
                  image: "images/car_card/speedometer.png",
                  text: "${widget.mileage}",
                  imageHeight: 25,
                  imageWidth: 25,
                ),
                CarPrimarySpecific(
                  image: "images/car_card/upload.png",
                  text: "${widget.uploadDate}",
                  imageHeight: 25,
                  imageWidth: 25,
                ),
              ],
            )
          ]),
        ));
  }
}

class CustomCarDetailHeder extends StatefulWidget {
  final String model;
  final String make;
  final int year;
  final double carPrice;
  final String carLocation;
  final String uploadDate;
  final List<Widget> carImage;
  const CustomCarDetailHeder(
      {super.key,
      required this.model,
      required this.make,
      required this.year,
      required this.carPrice,
      required this.carLocation,
      required this.uploadDate,
      required this.carImage});

  @override
  State<CustomCarDetailHeder> createState() => _CustomCarDetailHederState();
}

class _CustomCarDetailHederState extends State<CustomCarDetailHeder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        height: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Colors.blue[300]
          border: Border.all(width: 1, color: Colors.blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.grey,
              height: 200,
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      // reverse: true,
                      onPageChanged: (value) {
                        setState(() {});
                      },
                      itemCount: widget.carImage.length,
                      itemBuilder: (context, index) {
                        return widget.carImage[index];
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "لرؤية المزيد من الصور اسحب لليمين",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),

            Column(
              children: [
                Text(
                  "${widget.make} ${widget.model} ${widget.year}",
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "${widget.carPrice} ريال سعودي",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/clock.png",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.uploadDate}",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.carLocation}",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}

class CustomCarDetailCard extends StatefulWidget {
  final String model;
  final String manufacturer;
  final int year;
  final String color;
  final int mileage;
  final bool isManualGear;
  // final String

  const CustomCarDetailCard(
      {super.key,
      required this.model,
      required this.manufacturer,
      required this.year,
      required this.color,
      required this.mileage,
      required this.isManualGear});

  @override
  State<CustomCarDetailCard> createState() => _CustomCarDetailCardState();
}

class _CustomCarDetailCardState extends State<CustomCarDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      height: 370,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.circular(30),
        // color: Colors.grey[300]
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "الطراز",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.model}",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "الشركة المصنعة",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.manufacturer}",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "سنة التصنيع",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.year}",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "اللون",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.color}",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "الممشى",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.mileage}km",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "القير",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.isManualGear ? "عادي" : "اوتوماتيك",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "وثيقة الفحص الدوري",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.blue,
              icon: Icon(Icons.file_open_outlined),
            )
          ],
        ),
      ]),
    );
  }
}

class CustomCarDesc extends StatelessWidget {
  final String desc;
  const CustomCarDesc({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey[300]),
      child: Text(
        "$desc",
        style: TextStyle(
            fontSize: 16, fontFamily: "Rubik", fontWeight: FontWeight.w500),
      ),
    );
  }
}
