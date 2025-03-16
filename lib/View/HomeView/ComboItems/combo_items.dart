// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/HomeView/ComboItems/combo_items_model.dart';
import 'package:food_go/View/HomeView/home_view_detail.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class ComboItems extends StatelessWidget {
  const ComboItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        for (int i = 0; i < isFavoriteCombos.length; i++) {
          isFavoriteCombos[i] = prefs.getBool("isFavorite2_$i") ?? false;
        }
        FirebaseFirestore.instance
            .collection("foodCombos")
            .snapshots()
            .listen((snapshot) {
          viewModel.displayItems = snapshot.docs.toList();
        });
        viewModel.rebuildUi();
      },
      viewModelBuilder: () => ComboItemsModel(),
      builder: (context, viewModel, child) {
        return StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('foodCombos').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: MyTextField(
                          onChanged: (value) => viewModel.searchValue(value),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              5,
                              4,
                              6,
                              4,
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.mainTheme,
                                ),
                                child: Icon(Icons.search,
                                    color: AppColors.whiteColor)),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          borderColor: Colors.transparent,
                          fillColor: AppColors.whiteColor,
                          hintStyle: TextStyle(color: AppColors.blackColor),
                          controller: viewModel.searchController,
                          label: "Search Here"),
                    ),
                    height(getHeight(context, 0.02)),
                    Expanded(
                      child: (viewModel.searchController.text.isNotEmpty &&
                              viewModel.displayItems
                                  .where((element) => element["itemName"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(viewModel.searchController.text
                                          .toLowerCase()))
                                  .toList()
                                  .isEmpty)
                          ? const Center(
                              child: Text("No Item Found"),
                            )
                          : GridView.builder(
                              itemCount: viewModel.displayItems.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 2 / 2.2),
                              itemBuilder: (context, index) {
                                DocumentSnapshot item =
                                    viewModel.displayItems[index];
                                return Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(15),
                                  child: GestureDetector(
                                    onTap: () async {
                                      final data = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeViewDetail(
                                                    index: index,
                                                    isFavorite:
                                                        isFavoriteCombos,
                                                    id: item.id,
                                                    image: item["image"],
                                                    quantity: comboQuantity,
                                                    fromCombo: true,
                                                  )));
                                      if (data != null) {
                                        isFavoriteCombos = data[0];
                                        comboQuantity = data[1];
                                        index = data[4];
                                      }
                                      viewModel.rebuildUi();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: Image.asset(
                                            "assets/images/${item["image"]}.png",
                                            scale: 2.2,
                                          )),
                                          height(MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.003),
                                          Text(
                                            "${item["itemName"]}",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${item["itemName_2"]}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          height(MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.003),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 18,
                                                color: AppColors.yellowColor,
                                              ),
                                              Text(
                                                "${item["itemRating"]}",
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Spacer(),
                                              InkWell(
                                                onTap: () async {
                                                  viewModel.itemId = item.id;
                                                  if (isFavoriteCombos[index] ==
                                                      false) {
                                                    isFavoriteCombos[index] =
                                                        true;
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setBool(
                                                        "isFavorite2_$index",
                                                        true);
                                                    isFavoriteCombos[index] =
                                                        prefs.getBool(
                                                            "isFavorite2_$index")!;
                                                    favoriteItems.add({
                                                      "userID":
                                                          userDetails!.uid,
                                                      "index": index,
                                                      "itemID": item.id,
                                                      "image": item["image"],
                                                      "itemName":
                                                          item["itemName"],
                                                      "itemPrice":
                                                          item["itemPrice"],
                                                      "itemRating":
                                                          item["itemRating"],
                                                      "itemName_2":
                                                          item["itemName_2"],
                                                      "itemDescription": item[
                                                          "itemDescription"],
                                                    });
                                                    await viewModel
                                                        .updateUser(
                                                            context: context)
                                                        .then((value) {
                                                      mySuccessSnackBar(
                                                          context: context,
                                                          message:
                                                              "Add to Favorites");
                                                    });
                                                  } else if (isFavoriteCombos[
                                                          index] ==
                                                      true) {
                                                    isFavoriteCombos[index] =
                                                        false;
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setBool(
                                                        "isFavorite2_$index",
                                                        false);
                                                    isFavoriteCombos[index] =
                                                        prefs.getBool(
                                                            "isFavorite2_$index")!;
                                                    favoriteItems.removeWhere(
                                                        (e) =>
                                                            e["itemID"] ==
                                                            item.id);
                                                    await viewModel
                                                        .updateUser(
                                                            context: context)
                                                        .then((value) {
                                                      myErrorSnackBar(
                                                          context: context,
                                                          message:
                                                              "Removed Successfully");
                                                    });
                                                  }
                                                  viewModel.rebuildUi();
                                                },
                                                child: isFavoriteCombos[index]
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(Icons
                                                        .favorite_border_outlined),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainTheme,
                  ),
                );
              }
            });
      },
    );
  }
}
