import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:moharrek/pages/auth/username_page.dart';
import 'package:pinput/pinput.dart';

class OTPValidationPage extends StatefulWidget {
  const OTPValidationPage({super.key});

  @override
  State<OTPValidationPage> createState() => _OTPValidationPageState();
}

class _OTPValidationPageState extends State<OTPValidationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: Colors.grey,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.asset("images/otp_val.png"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "رمز التفعيل",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "الرجاء إدخال رمز التفعيل المرسل إلى هاتفك",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        showCursor: true,
                        onCompleted: (value) => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => UsernamePage())),
                        defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.blue)),
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
