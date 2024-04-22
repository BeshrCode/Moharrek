import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moharrek/widget/home_widget.dart';
import 'package:pinput/pinput.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  String? searchValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  List<Map> usedCars = [
    {
      "model": "كامري",
      "make": "تويوتا",
      "year": 2020,
      "seller": "mohammed",
      "isNew": false,
      "price": 23000.0,
      "location": "مكة",
      "mileage": 45000,
      "uploadDate": "3 ايام",
      "image": "images/car_card/blue_car.jpg",
    },
    {
      "model": "موستينق",
      "make": "فورد",
      "year": 2020,
      "seller": "mohammed",
      "isNew": false,
      "price": 23000.0,
      "location": "مكة",
      "mileage": 45000,
      "uploadDate": "3 ايام",
      "image": "images/car_2.jpg",
    },
    {
      "model": "كامري",
      "make": "تويوتا",
      "year": 2020,
      "seller": "mohammed",
      "isNew": false,
      "price": 23000.0,
      "location": "مكة",
      "mileage": 45000,
      "uploadDate": "3 ايام",
      "image": "images/car_card/blue_car.jpg",
    },
    {
      "model": "موستينق",
      "make": "فورد",
      "year": 2020,
      "seller": "mohammed",
      "isNew": false,
      "price": 23000.0,
      "location": "مكة",
      "mileage": 45000,
      "uploadDate": "3 ايام",
      "image": "images/car_2.jpg",
    },
  ];

  List<Map> newCars = [
    {
      "model": "موستينق",
      "make": "فورد",
      "year": 2020,
      "price": 23000.0,
      "location": "مكة المكرمة",
      "image": "images/car_2.jpg",
    },
    {
      "model": "كامري",
      "make": "تويوتا",
      "year": 2020,
      "price": 23000.0,
      "location": "مكة المكرمة",
      "image": "images/car_card/blue_car.jpg",
    }
  ];

  List<Map<dynamic, dynamic>> searchedInUsedCars = [];
  List<Map<dynamic, dynamic>> searchedInNewCars = [];
  List<Map<dynamic, dynamic>> selectedCars = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CupertinoSearchTextField(
            backgroundColor: Colors.white,
            placeholder: "بحث...",
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            onChanged: (value) {
              print(value);
              searchValue = value;
              searchedInUsedCars = usedCars
                  .where((car) =>
                      car['model'].toString().contains(value) ||
                      car['make'].toString().contains(value))
                  .toList();
              searchedInNewCars = newCars
                  .where((car) =>
                      car['model'].toString().contains(value) ||
                      car['make'].toString().contains(value))
                  .toList();

              setState(() {});
            },
          ),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            indicatorWeight: 4,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 16,
              fontFamily: "NotoKufiArabic",
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: "مستعمل",
              ),
              Tab(
                text: "وكالة",
              ),
            ],
          )),
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: TabBarView(
          controller: tabController,
          children: [
            UsedCarTabBarView(
              searchValue: searchValue,
              selectedCars: searchedInUsedCars.isEmpty || searchValue == null
                  ? usedCars
                  : searchedInUsedCars,
            ),
            NewCarTabView(
              searchValue: searchValue,
              selectedCars: searchedInNewCars.isEmpty || searchValue == null
                  ? newCars
                  : searchedInNewCars,
            )
          ],
        ),
      ),
    );
  }
}

class UsedCarTabBarView extends StatefulWidget {
  final String? searchValue;
  final List<Map> selectedCars;
  const UsedCarTabBarView(
      {super.key, this.searchValue, required this.selectedCars});

  @override
  State<UsedCarTabBarView> createState() => _UsedCarTabBarViewState();
}

class _UsedCarTabBarViewState extends State<UsedCarTabBarView> {
  int selectedIndex = 0;

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
    return ListView(
      children: [
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
                splashColor: Colors.white,
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
          child: Text(
            "استكشف",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.selectedCars.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CustomUsedCarCard(
                          model: widget.selectedCars[index]["model"],
                          make: widget.selectedCars[index]["make"],
                          year: widget.selectedCars[index]["year"],
                          seller: widget.selectedCars[index]["seller"],
                          price: widget.selectedCars[index]["price"],
                          location: widget.selectedCars[index]["location"],
                          mileage: widget.selectedCars[index]["mileage"],
                          uploadDate: widget.selectedCars[index]["uploadDate"],
                          image: widget.selectedCars[index]["image"]),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        )

        // BottomNavigationBar(items: items)
      ],
    );
  }
}

class NewCarTabView extends StatefulWidget {
  final String? searchValue;
  final List<Map> selectedCars;
  const NewCarTabView(
      {super.key, this.searchValue, required this.selectedCars});

  @override
  State<NewCarTabView> createState() => _NewCarTabViewState();
}

class _NewCarTabViewState extends State<NewCarTabView> {
  int selectedIndex = 0;

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
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                splashColor: Colors.white,
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
        SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.selectedCars.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CustomNewCarCard(
                          model: widget.selectedCars[index]["model"],
                          make: widget.selectedCars[index]["make"],
                          year: widget.selectedCars[index]["year"],
                          price: widget.selectedCars[index]["price"],
                          location: widget.selectedCars[index]["location"],
                          image: widget.selectedCars[index]["image"]),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CustomCategories extends StatelessWidget {
  final String? text;
  final Color? cateColor;
  const CustomCategories(this.text, this.cateColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: 70,
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
