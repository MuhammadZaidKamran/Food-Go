// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/HomeView/AllItems/all_items_view_model.dart';
import 'package:food_go/View/HomeView/home_view_detail.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AllItems extends StatefulWidget {
  const AllItems({super.key});

  @override
  State<AllItems> createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          for (int i = 0; i < isFavoriteList.length; i++) {
            isFavoriteList[i] = prefs.getBool("isFavorite_$i") ?? false;
          }
          // viewModel.displayItems =
          FirebaseFirestore.instance
              .collection("all items")
              .snapshots()
              .listen((snapshot) {
            viewModel.displayItems = snapshot.docs.toList();
          });
          // .then((snapshot) => snapshot.docs);
          viewModel.rebuildUi();
        },
        viewModelBuilder: () => AllItemsViewModel(),
        builder: (context, viewModel, child) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('all items')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(12),
                        child: MyTextField(
                            onChanged: (value) => viewModel.searchValue(value),
                            prefixIcon:
                                Icon(Icons.search, color: AppColors.blackColor),
                            borderRadius: BorderRadius.circular(12),
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
                                        .contains(viewModel
                                            .searchController.text
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
                                                          isFavoriteList,
                                                      id: item.id,
                                                      image: item["image"],
                                                      quantity: quantity,
                                                    )));
                                        if (data != null) {
                                          isFavoriteList = data[0];
                                          quantity = data[1];
                                          index = data[3];
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
                                              scale: 3.8,
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
                                                    // favoriteImage = "";
                                                    // bools[index] = !bools[index];
                                                    // viewModel.isFavorite =
                                                    // !viewModel.isFavorite;
                                                    if (isFavoriteList[index] ==
                                                        false) {
                                                      isFavoriteList[index] =
                                                          true;
                                                      // bools[index] = true;
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      // prefs.setBool("isFavorite", true);
                                                      // viewModel.isFavorite =
                                                      prefs.setBool(
                                                          "isFavorite_$index",
                                                          true);
                                                      isFavoriteList[index] =
                                                          prefs.getBool(
                                                              "isFavorite_$index")!;
                                                      // await viewModel.updateFavorites(
                                                      //     image: item["image"],
                                                      //     itemName: item["itemName"],
                                                      //     itemPrice: item["itemPrice"],
                                                      //     itemRating: item["itemRating"],
                                                      //     itemName_2: item["itemName_2"],
                                                      //     itemDescription:
                                                      //         item["itemDescription"],
                                                      //     itemQuantity:
                                                      //         item["itemQuantity"],
                                                      //     isFavorite: true,
                                                      //     context: context);
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
                                                      await viewModel.addToFavorites(
                                                          index: index,
                                                          image: item["image"],
                                                          itemName:
                                                              item["itemName"],
                                                          itemPrice:
                                                              item["itemPrice"],
                                                          itemRating: item[
                                                              "itemRating"],
                                                          itemName_2: item[
                                                              "itemName_2"],
                                                          itemDescription: item[
                                                              "itemDescription"],
                                                          isFavorite: true,
                                                          context: context);
                                                      await viewModel.updateUser(
                                                          // image: item["image"],
                                                          // itemName: item["itemName"],
                                                          // itemPrice: item["itemPrice"],
                                                          // itemRating: item["itemRating"],
                                                          // itemName_2: item["itemName_2"],
                                                          // itemDescription:
                                                          //     item["itemDescription"],
                                                          // isFavorite: true,
                                                          context: context);
                                                      // favoriteImage.add(images[index]);
                                                    } else if (isFavoriteList[
                                                            index] ==
                                                        true) {
                                                      isFavoriteList[index] =
                                                          false;
                                                      // bools[index] = false;
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      // prefs.setBool("isFavorite", false);
                                                      // bools[index] =
                                                      //     prefs.getBool("isFavorite")!;
                                                      prefs.setBool(
                                                          "isFavorite_$index",
                                                          false);
                                                      isFavoriteList[index] =
                                                          prefs.getBool(
                                                              "isFavorite_$index")!;
                                                      //     image: item["image"],
                                                      //     itemName: item["itemName"],
                                                      //     itemPrice: item["itemPrice"],
                                                      //     itemRating: item["itemRating"],
                                                      //     itemName_2: item["itemName_2"],
                                                      //     itemDescription:
                                                      //         item["itemDescription"],
                                                      //     itemQuantity:
                                                      //         item["itemQuantity"],
                                                      //     isFavorite: false,
                                                      //     context: context);
                                                      favoriteItems.removeWhere(
                                                          (e) =>
                                                              e["itemID"] ==
                                                              item.id);
                                                      await viewModel
                                                          .removeFavorites(
                                                              context: context);
                                                      await viewModel
                                                          .updateUser(
                                                              context: context);
                                                      // favoriteImage.remove(images[index]);
                                                    }
                                                    // if (await item["isFavorite"] ==
                                                    //     true) {
                                                    //   await viewModel.addToFavorites(
                                                    //       itemName: item["itemName"],
                                                    //       itemPrice: item["itemPrice"],
                                                    //       itemRating: item["itemRating"],
                                                    //       itemName_2: item["itemName_2"],
                                                    //       itemDescription:
                                                    //           item["itemDescription"],
                                                    //       itemQuantity:
                                                    //           item["itemQuantity"],
                                                    //       isFavorite: true,
                                                    //       context: context);
                                                    //   favoriteImage.add(images[index]);
                                                    // } else {
                                                    //   await viewModel.removeFavorites(
                                                    //       context: context);
                                                    //   favoriteImage.remove(images[index]);
                                                    // }
                                                    viewModel.rebuildUi();
                                                  },
                                                  child: isFavoriteList[index]
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
        });
  }
}
