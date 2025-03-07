import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/EditProfileViewModel/edit_profile_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          viewModel.nameController.text = prefs.getString("userName") ?? "";
          viewModel.phoneController.text = prefs.getString("phoneNumber") ?? "";
        },
        viewModelBuilder: () => EditProfileViewModel(),
        builder: (context, viewModel, index) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Edit Profile"),
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
                    height(40),
                    MyTextField(
                      controller: viewModel.nameController,
                      label: "Name",
                      hintStyle: TextStyle(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height(20),
                    MyTextField(
                      controller: viewModel.phoneController,
                      label: "Contact Number",
                      hintStyle: TextStyle(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height(40),
                    MyButton(
                        isLoading: viewModel.isLoading,
                        onTap: () async {
                          viewModel.isLoading = true;
                          viewModel.rebuildUi();
                          await viewModel
                              .updateProfile(
                            userName: viewModel.nameController.text,
                            phoneNumber: viewModel.phoneController.text,
                            context: context,
                          )
                              .then((value) {
                            viewModel.isLoading = false;
                            viewModel.rebuildUi();
                          }).catchError((error) {
                            viewModel.isLoading = false;
                            viewModel.rebuildUi();
                          });
                        },
                        label: "Update")
                  ],
                ),
              ),
            ),
          );
        });
  }
}
