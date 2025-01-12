import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/HomeView/AllItems/all_items.dart';
import 'package:food_go/ViewModel/HomeViewModel/home_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyDrawer/my_drawer.dart';
import 'package:food_go/utils/Widgets/MyTabbar/my_tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          FirebaseFirestore.instance
              .collection("users")
              .snapshots()
              .listen((snapshot) {
            // setState(() {
            favoriteItems = snapshot.docs
                .where((doc) =>
                    doc["userID"] == FirebaseAuth.instance.currentUser!.uid)
                .map((doc) => doc["favoriteItems"])
                .expand((item) => item) // Flatten the list of lists
                .toList();
            cartItems = snapshot.docs
                .where((doc) =>
                    doc["userID"] == FirebaseAuth.instance.currentUser!.uid)
                .map((doc) => doc["cartItems"])
                .expand((item) => item) // Flatten the list of lists
                .toList();
            // });
            viewModel.rebuildUi();
            viewModel.notifyListeners();
          });
        },
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            key: viewModel.scaffoldKey,
            drawer: const MyDrawer(),
            appBar: AppBar(
              toolbarHeight: 25,
              automaticallyImplyLeading: false,
              leading: InkWell(
                onTap: () {
                  viewModel.scaffoldKey.currentState!.openDrawer();
                },
                child: Icon(
                  Icons.menu_rounded,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            body: DefaultTabController(
              length: 2,
              child: Padding(
                padding: myPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Foodgo",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text("Order your favourite food!"),
                    height(MediaQuery.of(context).size.height * 0.03),
                    const MyTabBar(tabOne: "All", tabTwo: "Combos"),
                    height(MediaQuery.of(context).size.height * 0.02),
                    Expanded(
                      child: TabBarView(children: [
                        const AllItems(),
                        Container(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}


                    // SizedBox(
                    //     height: MediaQuery.of(context).size.height * 0.05,
                    //     width: MediaQuery.of(context).size.width,
                    //     child: ListView.separated(
                    //         shrinkWrap: true,
                    //         scrollDirection: Axis.horizontal,
                    //         itemBuilder: (context, index) {
                    //           return GestureDetector(
                    //             onTap: () {
                    //               viewModel.myIndex = index;
                    //               viewModel.rebuildUi();
                    //             },
                    //             child: Container(
                    //               width: MediaQuery.of(context).size.width * 0.42,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 color: viewModel.myIndex == index
                    //                     ? AppColors.mainTheme
                    //                     : AppColors.containerBackgroundColor,
                    //               ),
                    //               padding: const EdgeInsets.symmetric(
                    //                   horizontal: 5, vertical: 3),
                    //               child: Center(
                    //                   child: Text(
                    //                 viewModel.options[index].toString(),
                    //                 style: TextStyle(
                    //                     color: viewModel.myIndex == index
                    //                         ? AppColors.whiteColor
                    //                         : AppColors.blackColor,
                    //                     fontSize: 15,
                    //                     fontWeight: FontWeight.w700),
                    //               )),
                    //             ),
                    //           );
                    //         },
                    //         separatorBuilder: (context, index) {
                    //           return width(
                    //               MediaQuery.of(context).size.width * 0.05);
                    //         },
                    //         itemCount: viewModel.options.length)),