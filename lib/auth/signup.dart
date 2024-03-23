import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:moharrek/components/AuthButton.dart';
import 'package:moharrek/components/Logo.dart';
import 'package:moharrek/components/TextFormField.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController username = TextEditingController();
  late TextEditingController phoneNumber = TextEditingController();
  // late TextEditingController password = TextEditingController();
  bool isLaoding = false;
  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formState,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Moharrek",
                  style: TextStyle(
                      fontSize: 44,
                      color: Colors.blue,
                      fontFamily: "CormorantSC",
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text("إنشاء حساب",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(height: 10),
              Container(
                child: Text(
                  "أنشئ حساب للمتابعة",
                  style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "إسم المستخدم",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomeTextFormField(
                hint: "أدخل اسم المستخدم",
                myController: username,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Text(
                  "رقم الهاتف",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CustomePhoneNumberTextFormField(
                    hint: "مثال: 560000000",
                    myController: phoneNumber,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "🇸🇦 +996",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              CustomeAuthButton(
                  text: "متابعة",
                  color: Colors.blue,
                  isLoading: isLaoding,
                  onPressed: () {
                    if (formState.currentState!.validate()) {
                      print("============ yes");
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "لديك حساب بالفعل؟  "),
                    TextSpan(
                        text: "سجل الدخول",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold))
                  ]),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
