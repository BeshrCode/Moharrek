import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moharrek/components/button.dart';
import 'package:moharrek/pages/auction/car_details_page.dart';

class CustomAuctionCarCard extends StatefulWidget {
  final String model;
  final String make;
  final int year;
  final double higherBid;
  final String endDate;
  final String image;
  const CustomAuctionCarCard(
      {super.key,
      required this.year,
      required this.image,
      required this.higherBid,
      required this.endDate,
      required this.model,
      required this.make});

  @override
  State<CustomAuctionCarCard> createState() => _CustomAuctionCarCardState();
}

class _CustomAuctionCarCardState extends State<CustomAuctionCarCard> {
  var formatter = NumberFormat();
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35),
          // height: 120,
          width: 210,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                top: 15,
                left: 10,
                right: 10,
              ),
              // alignment: Alignment.topCenter,
              color: Colors.white,
              height: 150,
              width: 200,
              child: Image.asset(
                widget.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${widget.make} ${widget.model} ${widget.year}",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "ينتهي: ${widget.endDate}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "وصل السوم:  ${formatter.format(widget.higherBid)} ر.س",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            CustomeButton(
                text: "التفاصيل",
                color: Colors.blue,
                height: 0,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AuctionCarDetailPage()));
                },
                isLoading: false),
            SizedBox(
              height: 10,
            )
          ]),
        ));
  }
}

class CustomAuctionInfoCard extends StatefulWidget {
  final double higherBid;
  final String endDate;
  final double bidLimit;
  const CustomAuctionInfoCard(
      {super.key,
      required this.higherBid,
      required this.endDate,
      required this.bidLimit});

  @override
  State<CustomAuctionInfoCard> createState() => _CustomAuctionInfoCardState();
}

class _CustomAuctionInfoCardState extends State<CustomAuctionInfoCard> {
  var formatter = NumberFormat();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.blue),
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("وصل السوم",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("${widget.higherBid} ر.س",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("ينتهي المزاد",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("${widget.endDate}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("تبدأ المزايدة من",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("${formatter.format(widget.bidLimit)} ر.س",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(
          height: 5,
        )
      ]),
    );
  }
}

class CustomAuctionCarDetailHeader extends StatefulWidget {
  final String make;
  final String model;
  final int year;
  final List<Widget> carImage;
  const CustomAuctionCarDetailHeader(
      {super.key,
      required this.make,
      required this.model,
      required this.year,
      required this.carImage});

  @override
  State<CustomAuctionCarDetailHeader> createState() =>
      _CustomAuctionCarDetailHeaderState();
}

class _CustomAuctionCarDetailHeaderState
    extends State<CustomAuctionCarDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: Colors.blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.grey,
              height: 190,
              child: Column(
                children: [
                  Container(
                    height: 160,
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

            Text(
              "${widget.make} ${widget.model} ${widget.year}",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
