import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/ProfileViewModel/profile_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, this.goBack = false});
  final bool? goBack;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          viewModel.nameController.text = prefs.getString("userName") ?? "";
          viewModel.emailController.text =
              FirebaseAuth.instance.currentUser?.email ?? "";
          viewModel.phoneController.text = prefs.getString("phoneNumber") ?? "";
        },
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              leading: goBack == true
                  ? InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                      ),
                    )
                  : null,
              automaticallyImplyLeading: false,
              title: const Text("Profile"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Center(
                child: Column(
                  children: [
                    const ClipOval(
                      child: Icon(
                        Icons.account_circle,
                        size: 100,
                      ),
                    ),
                    height(20),
                    MyTextField(
                      readOnly: true,
                      controller: viewModel.nameController,
                      label: "Name",
                      hintStyle: TextStyle(color: AppColors.blackColor),
                    ),
                    height(20),
                    MyTextField(
                      readOnly: true,
                      controller: viewModel.emailController,
                      label: "Email",
                      hintStyle: TextStyle(color: AppColors.blackColor),
                    ),
                    height(20),
                    MyTextField(
                      readOnly: true,
                      controller: viewModel.phoneController,
                      label: "Contact Number",
                      hintStyle: TextStyle(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
