import 'package:flutter/material.dart';
import 'package:moharrek/components/AuthButton.dart';
import 'package:moharrek/components/Logo.dart';
import 'package:moharrek/components/TextFormField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController email = TextEditingController();
  late TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool isLoadingWithEmailAndPassword = false;
  bool isLoadingWithGoogle = false;

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
                      color: Colors.red,
                      fontFamily: "CormorantSC",
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login To Continue Using The App",
                  style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Email",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                hint: "Enter Your Email",
                myController: email,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomeTextFormField(
                hint: "Enter Your Password",
                myController: password,
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomeAuthButton(
                  text: "Login",
                  color: Colors.orange,
                  isLoading: isLoadingWithEmailAndPassword,
                  onPressed: () async {}),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "Don't Have An Account? "),
                    TextSpan(
                        text: "Register",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold))
                  ]),
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
