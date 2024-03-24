import 'package:flutter/material.dart';
import 'package:moharrek/components/AuthButton.dart';
import 'package:moharrek/components/TextFormField.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formState,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image.asset("images/register.jpg"),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text("إنشاء اسم المستخدم",
                    style: Theme.of(context).textTheme.titleSmall),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "أدخل اسم مستخدم خاص بك للمتابعة ",
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomeTextFormField(
                  hint: "اسم المستخدم", myController: username),
              const SizedBox(
                height: 5,
              ),
              Text(
                "ملاحظة: سيكون اسم المستخدم مرئي للجميع ",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomeAuthButton(
                  text: "متابعة",
                  color: Colors.blue,
                  isLoading: isLoading,
                  onPressed: () {
                    if (formState.currentState!.validate()) {}
                  }),
            ],
          ),
        ));
  }
}
