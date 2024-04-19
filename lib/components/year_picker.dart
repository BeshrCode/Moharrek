import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomYearPicker extends StatefulWidget {
  final Function(int) selectedYear;
  const CustomYearPicker({super.key, required this.selectedYear});

  @override
  State<CustomYearPicker> createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  int selectedValue = DateTime.now().year;
  List<int> yearList = List.generate(DateTime.now().year - 1980 + 1, (index) {
    int year = 1980 + index;
    return year;
  });
  List<Widget> yearWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int num in yearList) {
      yearWidgets.add(Text(num.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(30)),
          child: CupertinoButton(
              // color: Colors.blue,
              // borderRadius: BorderRadius.circular(30),
              child: Text(
                " حدد سنة الصنع: $selectedValue",
                style: TextStyle(fontFamily: "NotoKufiArabic", fontSize: 16),
              ),
              disabledColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 30,
                      scrollController: FixedExtentScrollController(
                          initialItem: yearList.length - 1),
                      children: yearWidgets,
                      onSelectedItemChanged: (int value) {
                        selectedValue = yearList[value];
                        widget.selectedYear(selectedValue);
                        setState(() {});
                      },
                    ),
                  ),
                );
              })),
    );
  }
}
