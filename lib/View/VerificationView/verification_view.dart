import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/VerificationViewModel/verification_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:stacked/stacked.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => VerificationViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(getHeight(context, 0.1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                height(getHeight(context, 0.1)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    "We have sent an Email for Verification!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                height(getHeight(context, 0.02)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: MyButton(
                      onTap: () async {
                        await FirebaseAuth.instance.currentUser!
                            .sendEmailVerification()
                            .then((value) {
                          mySuccessSnackBar(
                              // ignore: use_build_context_synchronously
                              context: context,
                              message: "Email Sent Successfully");
                        });
                      },
                      label: "Resend Email"),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    "assets/images/verification_view_img.png",
                    scale: 5,
                  ),
                )
              ],
            ),
          );
        });
  }
}
