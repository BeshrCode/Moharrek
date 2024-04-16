import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:moharrek/pages/auth/otp_validation_page.dart';
import 'package:moharrek/components/AuthButton.dart';
import 'package:moharrek/components/Logo.dart';
import 'package:moharrek/components/TextFormField.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController phoneNumber = TextEditingController();
  // late TextEditingController password = TextEditingController();

  Country country = Country(
      phoneCode: "996",
      countryCode: "SA",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Saudi",
      example: "Saudi",
      displayName: "Saudi",
      displayNameNoCountryCode: "SA",
      e164Key: "");

  bool isLaoding = false;
  GlobalKey<FormState> formState = GlobalKey();
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumber.dispose();
  }

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
              child: Text("التسجيل",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "أدخل رقم الهاتف للمتابعة",
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomePhoneNumberTextFormField(
              hint: "5xxxxxxxx",
              myController: phoneNumber,
              suffixIcon: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "${country.flagEmoji} +${country.phoneCode}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPValidationPage()));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
