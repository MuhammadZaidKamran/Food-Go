import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/CartView/cart_view.dart';
import 'package:food_go/View/HomeView/AllItems/all_items.dart';
import 'package:food_go/ViewModel/HomeViewModel/home_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyDrawer/my_drawer.dart';
import 'package:food_go/utils/Widgets/MyTabbar/my_tab_bar.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          await platFormFees();
          viewModel.getCurrentAddress();
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
            // viewModel.rebuildUi();
            viewModel.notifyListeners();
          });
          viewModel.rebuildUi();
        },
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            key: viewModel.scaffoldKey,
            drawer: const MyDrawer(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(getHeight(context, 0.09)),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 45, 10, 0),
                decoration: BoxDecoration(
                    color: AppColors.mainTheme,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              viewModel.scaffoldKey.currentState!.openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        width(getWidth(context, 0.01)),
                        Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 15, color: AppColors.whiteColor),
                        ),
                        const Spacer(),
                        cartItems.isEmpty
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const CartView()));
                                },
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 25,
                                  color: AppColors.whiteColor,
                                ),
                              )
                            : Badge(
                                offset: const Offset(-14, -3),
                                backgroundColor: AppColors.whiteColor,
                                label: Text(
                                  cartItems.length.toString(),
                                  style: TextStyle(
                                    color: AppColors.mainTheme,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const CartView()));
                                  },
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 25,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    height(getHeight(context, 0.007)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                          color: AppColors.whiteColor,
                        ),
                        width(getWidth(context, 0.01)),
                        SizedBox(
                          width: getWidth(context, 0.85),
                          child: Text(
                            userCurrentAddress ?? "Get Access To Location",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(10),
              //     bottomRight: Radius.circular(10),
              //   ),
              // ),
              // backgroundColor: AppColors.mainTheme,
              // // toolbarHeight: 25,
              // automaticallyImplyLeading: false,
              // leading: InkWell(
              //   onTap: () {
              //     viewModel.scaffoldKey.currentState!.openDrawer();
              //   },
              //   child: Icon(
              //     Icons.menu_rounded,
              //     color: AppColors.whiteColor,
              //   ),
              // ),
              // title:
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
