import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/verify_screen.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isLoading = false;
  final phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: myPadding(),
        child: Column(
          children: [
            MyTextField(
              controller: phoneController,
              label: "Enter Phone Number",
              keyboardType: TextInputType.number,
            ),
            height(getHeight(context, 0.02)),
            MyButton(
                isLoading: isLoading,
                onTap: () {
                  isLoading = true;
                  setState(() {});
                  auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    verificationCompleted: (_) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    verificationFailed: (value) {
                      setState(() {
                        isLoading = false;
                      });
                      myErrorSnackBar(
                          context: context, message: value.toString());
                    },
                    codeSent: (String verificationID, int? token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyScreen(
                                  verificationID: verificationID,
                                )),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (value) {
                      myErrorSnackBar(
                          context: context, message: value.toString());
                      setState(() {
                        isLoading = false;
                      });
                    },
                  );
                },
                label: "Send OTP"),
          ],
        ),
      ),
    );
  }
}
