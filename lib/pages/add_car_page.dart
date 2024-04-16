// import 'dart:math';

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moharrek/components/TextFormField.dart';
import 'package:moharrek/components/dropdown_menu_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  String model = "";
  String? manufacturer;
  bool isManufacturerSelected = false;
  int year = 0;
  TextEditingController mileage = TextEditingController();
  List<String> manufacturers = [
    "Toyota",
    "Nissan",
    "Ford",
    "BMW",
  ];

  Map models = {
    "Toyota": ['Camry', 'Corolla', 'RAV4', 'Highlander'],
    "Nissan": ['Altima', 'Maxima', 'Rogue', 'Pathfinder'],
    "Ford": ['Ford F-150', 'Ford Mustang', 'Ford Explorer', 'Ford Escape'],
    "BMW": ['BMW 3 Series', 'BMW 5 Series', 'BMW X5', 'BMW i8']
  };

  String? selectedManufacturer;
  String? selectedModel;
  List<File> imageList = [];
  File? periodicInspection;

  addPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      periodicInspection = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
    setState(() {});
  }

  addImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick multiple images.
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      // Convert selected images to File objects and store them in the imageList.
      imageList = images.map((image) => File(image.path)).toList();
      setState(() {});
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "أضف مركبة",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            CustomDropdownMenuButton(
                hint: "اختر الشركة",
                hintSearch: "ابحث عن الشركة...",
                list: manufacturers,
                selectedValue: selectedManufacturer,
                onChanged: (value) {
                  selectedManufacturer = value;
                  selectedModel = null;
                  setState(() {});
                }),
            SizedBox(height: 20),
            CustomDropdownMenuButton(
                hint: "اختر المودل",
                hintSearch: "ابحث عن المودل...",
                list: models[selectedManufacturer] ?? ["empty"],
                selectedValue: selectedModel,
                onChanged: (value) {
                  selectedModel = value;
                  setState(() {});
                }),
            SizedBox(height: 20),
            // Text("اختر سنة التصنيع"),
            YearPicker(selectedYear: (value) {
              year = value;
              print(year);
            }),
            SizedBox(height: 30),

            CustomNumberTextFormField(
                hint: "أدخل مقدار الممشى...", myController: mileage),
            SizedBox(height: 20),
            Text("حدد نظام القير"),
            SizedBox(height: 5),
            ToggleSwitch(
              initialLabelIndex: 0,
              animate: true,
              animationDuration: 400,
              curve: Easing.legacy,
              minWidth: double.infinity,
              customWidths: [double.infinity, double.infinity],
              dividerColor: Colors.white,
              inactiveBgColor: Colors.white,
              borderColor: [Colors.blue],
              borderWidth: 1,
              cornerRadius: 0,
              totalSwitches: 2,
              activeBgColor: [Colors.blue],
              labels: ['أوتوماتيك', 'عادي'],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
            SizedBox(height: 25),

            InkWell(
              onTap: () {
                addImage();
              },
              child: DottedBorder(
                color: Colors.blue,
                strokeWidth: 1,
                child: Container(
                    decoration: BoxDecoration(
                      color: imageList.isEmpty
                          ? Colors.grey[200]
                          : Colors.blue[200],
                    ),
                    height: 100,
                    width: double.infinity,
                    child: imageList.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 25,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "ارفع صورة أو أكثر للمركبة",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageList.length,
                            itemBuilder: (context, index) {
                              return Image.file(
                                imageList[index],
                                height: 100,
                                width: 100,
                              );
                            },
                          )),
              ),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: InkWell(
                onTap: () {
                  addPDFFile();
                },
                child: DottedBorder(
                  color: Colors.blue,
                  strokeWidth: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        color: periodicInspection == null
                            ? Colors.grey[200]
                            : Colors.blue[200],
                      ),
                      height: 80,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            size: 25,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "ارفع الفحص الدوري للمركبة",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                if (imageList.isEmpty) {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'يجب رفع صورة واحدة على الأقل',
                          titleTextStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          descTextStyle: TextStyle(fontSize: 14),
                          btnOkColor: Colors.blue,
                          btnOkText: "إغلاق",
                          btnOkOnPress: () {})
                      .show();
                  return;
                }
                if (periodicInspection == null) {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'يجب رفع ملف الفحص الدوري',
                          titleTextStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          descTextStyle: TextStyle(fontSize: 14),
                          btnOkColor: Colors.blue,
                          btnOkText: "إغلاق",
                          btnOkOnPress: () {})
                      .show();
                  return;
                }
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'تنبيه',
                        desc:
                            'في حال كان هناك أي معلومات خاطئة؛ فسيتم حظر الحساب',
                        titleTextStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        descTextStyle: TextStyle(fontSize: 14),
                        btnOkColor: Colors.blue,
                        btnOkText: "استمرار",
                        btnCancelText: "إالغاء",
                        btnOkOnPress: () {},
                        btnCancelOnPress: () {})
                    .show();
              },
              child: Text(
                'نشر',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YearPicker extends StatefulWidget {
  final Function(int) selectedYear;
  const YearPicker({super.key, required this.selectedYear});

  @override
  State<YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
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
