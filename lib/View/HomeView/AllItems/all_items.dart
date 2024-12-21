// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/HomeView/AllItems/all_items_view_model.dart';
import 'package:food_go/View/HomeView/home_view_detail.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
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
        viewModelBuilder: () => AllItemsViewModel(),
        builder: (context, viewModel, child) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('all items')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 2 / 2.2),
                      itemBuilder: (context, index) {
                        DocumentSnapshot item = snapshot.data!.docs[index];
                        return Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () async {
                              final data = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeViewDetail(
                                            isFavorite: bools[index],
                                            id: item.id,
                                            image: item["image"],
                                            quantity: quantity[index],
                                          )));
                              if (data != null) {
                                bools[index] = data[0];
                                quantity[index] = data[1];
                              }
                              viewModel.rebuildUi();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                      child: Image.asset(
                                    "assets/images/${item["image"]}.png",
                                    scale: 3.8,
                                  )),
                                  height(MediaQuery.of(context).size.height *
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
                                  height(MediaQuery.of(context).size.height *
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          viewModel.itemId = item.id;
                                          // favoriteImage = "";
                                          // bools[index] = !bools[index];
                                          if (bools[index] == false) {
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
                                              "userID": FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              "itemID": item.id,
                                              "image": item["image"],
                                              "itemName": item["itemName"],
                                              "itemPrice": item["itemPrice"],
                                              "itemRating": item["itemRating"],
                                              "itemName_2": item["itemName_2"],
                                              "itemDescription":
                                                  item["itemDescription"],
                                              "isFavorite": true,
                                            });
                                            await viewModel.addToFavorites(
                                                image: item["image"],
                                                itemName: item["itemName"],
                                                itemPrice: item["itemPrice"],
                                                itemRating: item["itemRating"],
                                                itemName_2: item["itemName_2"],
                                                itemDescription:
                                                    item["itemDescription"],
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
                                          } else if (bools[index] == true) {
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
                                            //     isFavorite: false,
                                            //     context: context);
                                            favoriteItems.removeAt(index);
                                            await viewModel.removeFavorites(
                                                context: context);
                                            await viewModel.updateUser(
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
                                        child: bools[index]
                                            ? const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_border_outlined),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
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
