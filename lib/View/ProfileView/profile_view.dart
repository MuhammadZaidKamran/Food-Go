import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/ProfileViewModel/profile_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          // await viewModel.myInitMethod().then((value) {
          //   viewModel.nameController.text = viewModel.name;
          //   viewModel.emailController.text = viewModel.email;
          //   viewModel.phoneController.text = viewModel.phoneNumber;
          // });
        },
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
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
