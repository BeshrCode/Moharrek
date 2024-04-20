// import 'dart:js';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:moharrek/widget/auction_widget.dart';
import 'package:moharrek/components/button.dart';
import 'package:moharrek/components/text_form_field.dart';

class AuctionCarDetailPage extends StatefulWidget {
  const AuctionCarDetailPage({super.key});

  @override
  State<AuctionCarDetailPage> createState() => _AuctionCarDetailPageState();
}

class _AuctionCarDetailPageState extends State<AuctionCarDetailPage> {
  GlobalKey<FormState> fState = GlobalKey();

  TextEditingController bidAmount = TextEditingController();

  List<Widget> carImage = [
    Image.asset("images/car_card/blue_car.jpg"),
    Image.asset("images/car_2.jpg"),
  ];
  final List<Map> bidders = [
    {
      "name": "mohammed",
      "bid": 3200000,
    },
    {
      "name": "ahmed",
      "bid": 3000000,
    },
    {
      "name": "sami",
      "bid": 2800000,
    },
    {
      "name": "mohammed",
      "bid": 3200000,
    },
    {
      "name": "ahmed",
      "bid": 3000000,
    },
    {
      "name": "sami",
      "bid": 2800000,
    },
    {
      "name": "mohammed",
      "bid": 3200000,
    },
    {
      "name": "ahmed",
      "bid": 3000000,
    },
    {
      "name": "sami",
      "bid": 2800000,
    },
    {
      "name": "mohammed",
      "bid": 3200000,
    },
    {
      "name": "ahmed",
      "bid": 3000000,
    },
    {
      "name": "sami",
      "bid": 2800000,
    },
  ];

  Future openDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: fState,
            child: AlertDialog(
              title: Text("أدخل مبلغ المزايدة"),
              content: CustomNumberTextFormField(
                  hint: "أدخل المبلغ",
                  suffixIcon: Container(
                      padding: EdgeInsets.all(10), child: Text("ر.س")),
                  myController: bidAmount),
              actions: [
                TextButton(
                    onPressed: () {
                      if (!fState.currentState!.validate()) {
                        return;
                      }
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          title: 'تنبيه',
                          desc:
                              "عزيزي المستخدم.\nنأمل أن تدرك أن انسحابك من المزاد بعد الاشتراك فيه سيعرضك لعقوبات قانونية، يرجى تقديم عروضكم بجدية والالتزام بالشروط والأحكام.",
                          titleTextStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          descTextStyle: TextStyle(fontSize: 14),
                          btnOkColor: Colors.blue,
                          btnOkText: "استمرار",
                          btnCancelText: "إالغاء",
                          btnOkOnPress: () {
                            Navigator.of(context).pop();
                          },
                          btnCancelOnPress: () {
                            Navigator.of(context).pop();
                          }).show();
                    },
                    child: Text("موافق"))
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bidAmount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: Text('Title'),
            ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            CustomAuctionCarDetailHeader(
                make: "تويوتا", model: "كامري", year: 2023, carImage: carImage),
            SizedBox(height: 10),
            CustomAuctionInfoCard(
              higherBid: 320000,
              endDate: "07 شوال",
            ),
            SizedBox(height: 10),
            AuctionBidders(bidders: bidders),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CustomeButton(
                  text: "مزايدة",
                  color: Colors.blue,
                  height: 5,
                  onPressed: () {
                    openDialog();
                  },
                  isLoading: false),
            )
          ],
        ));
  }
}

class AuctionBidders extends StatefulWidget {
  // final List<String> bidders;
  final List<Map> bidders;
  const AuctionBidders({
    super.key,
    required this.bidders,
  });

  @override
  State<AuctionBidders> createState() => _AuctionBiddersState();
}

class _AuctionBiddersState extends State<AuctionBidders> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1, color: Colors.orange),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(
            "قائمة المزايدين",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 210,
            child: ListView.builder(
              itemCount: widget.bidders.length,
              itemBuilder: (context, index) {
                count++;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        count == 1
                            ? Text(
                                "1",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              )
                            : Text("$count"),
                        SizedBox(
                          width: 10,
                        ),
                        count == 1
                            ? Text("${widget.bidders[index]["name"]}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange))
                            : Text("${widget.bidders[index]["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                      ],
                    ),
                    count == 1
                        ? Text("${widget.bidders[index]["bid"]} ر.س",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange))
                        : Text("${widget.bidders[index]["bid"]} ر.س",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
