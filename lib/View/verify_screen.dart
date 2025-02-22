import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.verificationID});
  final String verificationID;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isLoading = false;
  final phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: myPadding(),
        child: Column(
          children: [
            MyTextField(
              controller: phoneController,
              label: "6-digit Code",
              keyboardType: TextInputType.number,
            ),
            height(getHeight(context, 0.02)),
            MyButton(
              isLoading: isLoading,
                onTap: () async {
                  final credentials = PhoneAuthProvider.credential(
                    verificationId: widget.verificationID,
                    smsCode: phoneController.text.toString(),
                  );
                  try {
                    await auth.signInWithCredential(credentials);
                    isLoading = false;
                    setState(() {});
                    mySuccessSnackBar(
                        context: context,
                        message: "Account Created Successfully");
                  } catch (value) {
                    myErrorSnackBar(
                        context: context, message: value.toString());
                    isLoading = false;
                    setState(() {});
                  }
                },
                label: "Verify"),
          ],
        ),
      ),
    );
  }
}
