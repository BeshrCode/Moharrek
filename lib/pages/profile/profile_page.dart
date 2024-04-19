import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moharrek/pages/profile/my_listing.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        // title: Text('Title'),
        // ),
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: ListView(
        children: [
          UnconstrainedBox(
            child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(60)),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
                )),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text("Mohammed",
                style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 2,
            color: Colors.grey[300],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MyListingPage()));
            },
            child: Row(
              children: [
                Icon(Icons.cases_rounded),
                SizedBox(
                  width: 10,
                ),
                Text("إعلاناتي",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(
                  width: 10,
                ),
                Text("الاعدادات",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.logout_rounded),
                SizedBox(
                  width: 10,
                ),
                Text("تسجيل الخروج",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
