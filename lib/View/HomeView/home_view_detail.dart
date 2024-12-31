// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/HomeViewModel/home_view_detail.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:food_go/utils/Widgets/PlusMinusContainer/plus_minus_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class HomeViewDetail extends StatelessWidget {
  HomeViewDetail(
      {super.key,
      required this.id,
      required this.image,
      required this.isFavorite,
      required this.quantity,
      required this.index});
  final String id;
  final String image;
  List<bool> isFavorite;
  List<int> quantity;
  int index;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewDetailModel(),
        onViewModelReady: (viewModel) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          for (var i = 0; i < quantity.length; i++) {
            quantity[i] = prefs.getInt("quantity_$i") ?? 0;
          }
          for (var i = 0; i < isFavorite.length; i++) {
            isFavorite[i] = prefs.getBool("isFavorite_$i")!;
          }
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 50, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, [
                        isFavorite,
                        quantity,
                        id,
                        index,
                      ]);
                    },
                    child: Image.asset(
                      "assets/images/arrow-left.png",
                      color: AppColors.blackColor,
                    ),
                  ),
                  Center(child: Image.asset("assets/images/$image.png")),
                  height(MediaQuery.of(context).size.height * 0.02),
                  Expanded(
                      child: FutureBuilder(
                          future: viewModel.allItems.doc(id).get(),
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          data!.get("itemName".toString()),
                                          style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Icon(Icons.star,
                                            size: 22,
                                            color: AppColors.yellowColor),
                                        width(
                                            MediaQuery.of(context).size.width *
                                                0.01),
                                        Text(
                                          data.get("itemRating".toString()),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    height(MediaQuery.of(context).size.height *
                                        0.004),
                                    Row(
                                      children: [
                                        Text(
                                          data.get("itemName_2".toString()),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "Rs.${data.get("itemPrice".toString())}",
                                          style: TextStyle(
                                              color: AppColors.blackColor,
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    height(MediaQuery.of(context).size.height *
                                        0.03),
                                    Text(
                                      data.get("itemDescription".toString()),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    height(MediaQuery.of(context).size.height *
                                        0.04),
                                    PlusMinusContainer(
                                      onTapMinus: () async {
                                        // int itemQuantity =
                                        //     data.get("itemQuantity");
                                        if (quantity[index] > 0) {
                                          quantity[index]--;
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setInt("quantity_$index",
                                              quantity[index]);
                                          prefs.getInt("quantity_$index");
                                          cartItems
                                              .where(
                                                  (e) => e["itemID"] == data.id)
                                              .forEach((element) {
                                            element["itemQuantity"] =
                                                quantity[index];
                                          });
                                          await viewModel.updateUser();
                                          viewModel.rebuildUi();
                                          //itemQuantity--;
                                          // quantity--;
                                          //viewModel.itemId = data.id;
                                          //   await viewModel.updateAddItems(
                                          //       data.get("image"),
                                          //       data.get("itemName".toString()),
                                          //       data.get("itemPrice".toString()),
                                          //       data.get("itemRating".toString()),
                                          //       data.get("itemName_2".toString()),
                                          //       data.get(
                                          //           "itemDescription".toString()),
                                          //       itemQuantity,
                                          //       context);
                                          //   await viewModel.updateAddToCart(
                                          //       data.get("image"),
                                          //       data.get("itemName".toString()),
                                          //       data.get("itemPrice".toString()),
                                          //       data.get("itemRating".toString()),
                                          //       data.get("itemName_2".toString()),
                                          //       data.get(
                                          //           "itemDescription".toString()),
                                          //       //itemQuantity,
                                          //       context);
                                          //   viewModel.rebuildUi();
                                        }
                                      },
                                      text: quantity[index].toString(),
                                      onTapPlus: () async {
                                        quantity[index]++;
                                        // cartItems[index]["itemQuantity"] =
                                        //     quantity[index];
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setInt(
                                            "quantity_$index", quantity[index]);
                                        prefs.getInt("quantity_$index");
                                        cartItems
                                            .where(
                                                (e) => e["itemID"] == data.id)
                                            .forEach((element) {
                                          element["itemQuantity"] =
                                              quantity[index];
                                        });
                                        await viewModel.updateUser();
                                        viewModel.rebuildUi();
                                        // cartItems
                                        // .where
                                        // ((e) => e["itemQuantity"]++);
                                        // int itemQuantity =
                                        //     data.get("itemQuantity");
                                        // itemQuantity++;
                                        // // quantity++;
                                        // viewModel.itemId = data.id;
                                        // await viewModel.updateAddItems(
                                        //     data.get("image"),
                                        //     data.get("itemName".toString()),
                                        //     data.get("itemPrice".toString()),
                                        //     data.get("itemRating".toString()),
                                        //     data.get("itemName_2".toString()),
                                        //     data.get(
                                        //         "itemDescription".toString()),
                                        //     itemQuantity,
                                        //     context);
                                        // await viewModel.updateAddToCart(
                                        //     data.get("image"),
                                        //     data.get("itemName".toString()),
                                        //     data.get("itemPrice".toString()),
                                        //     data.get("itemRating".toString()),
                                        //     data.get("itemName_2".toString()),
                                        //     data.get(
                                        //         "itemDescription".toString()),
                                        //     itemQuantity,
                                        //     context);
                                        // viewModel.rebuildUi();
                                      },
                                    ),
                                    height(MediaQuery.of(context).size.height *
                                        0.03),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // isFavorite = !isFavorite;
                                            viewModel.itemId = data.id;
                                            if (isFavorite[index] == false) {
                                              isFavorite[index] = true;
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool(
                                                  "isFavorite_$index", true);
                                              isFavorite[index] = prefs.getBool(
                                                  "isFavorite_$index")!;
                                              favoriteItems.add({
                                                "userID": userDetails!.uid,
                                                "index": index,
                                                "itemID": data.id,
                                                "image": image,
                                                "itemName":
                                                    data.get("itemName"),
                                                "itemPrice":
                                                    data.get("itemPrice"),
                                                "itemRating":
                                                    data.get("itemRating"),
                                                "itemName_2":
                                                    data.get("itemName_2"),
                                                "itemDescription":
                                                    data.get("itemDescription"),
                                              });
                                              await viewModel.updateUser();
                                              //   await viewModel.updateFavorites(
                                              //       image: data.get("image"),
                                              //       itemName:
                                              //           data.get("itemName"),
                                              //       itemPrice:
                                              //           data.get("itemPrice"),
                                              //       itemRating:
                                              //           data.get("itemRating"),
                                              //       itemName_2:
                                              //           data.get("itemName_2"),
                                              //       itemDescription: data
                                              //           .get("itemDescription"),
                                              //       itemQuantity:
                                              //           data.get("itemQuantity"),
                                              //       isFavorite: true,
                                              //       context: context);

                                              //   await viewModel.addToFavorites(
                                              //       image: data.get("image"),
                                              //       itemName: data.get(
                                              //           "itemName".toString()),
                                              //       itemPrice: data.get(
                                              //           "itemPrice".toString()),
                                              //       itemRating: data.get(
                                              //           "itemRating".toString()),
                                              //       itemName_2: data.get(
                                              //           "itemName_2".toString()),
                                              //       itemDescription: data.get(
                                              //           "itemDescription"
                                              //               .toString()),
                                              //       itemQuantity:
                                              //           data.get("itemQuantity"),
                                              //       isFavorite: true,
                                              //       context: context);
                                              //   favoriteImage.add(image);
                                              // } else if (data.get("isFavorite") ==
                                              //     true) {
                                              //   await viewModel.updateFavorites(
                                              //       image: data.get("image"),
                                              //       itemName:
                                              //           data.get("itemName"),
                                              //       itemPrice:
                                              //           data.get("itemPrice"),
                                              //       itemRating:
                                              //           data.get("itemRating"),
                                              //       itemName_2:
                                              //           data.get("itemName_2"),
                                              //       itemDescription: data
                                              //           .get("itemDescription"),
                                              //       itemQuantity:
                                              //           data.get("itemQuantity"),
                                              //       isFavorite: false,
                                              //       context: context);

                                              //   await viewModel.removeFavorites(
                                              //       context: context);
                                              //   favoriteImage.remove(image);
                                            } else if (isFavorite[index] ==
                                                true) {
                                              isFavorite[index] = false;
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool(
                                                  "isFavorite_$index", false);
                                              isFavorite[index] = prefs.getBool(
                                                  "isFavorite_$index")!;
                                              favoriteItems.removeWhere((e) =>
                                                  e["itemID"] == data.id);
                                              await viewModel.updateUser();
                                            }
                                            viewModel.rebuildUi();
                                          },
                                          child: isFavorite[index]
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: getWidth(context, 0.08),
                                                )
                                              : Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  size: getWidth(context, 0.08),
                                                ),
                                        ),
                                        const Spacer(),
                                        MyButton(
                                          label: "Add to cart",
                                          onTap: () async {
                                            // int itemQuantity =
                                            //     data.get("itemQuantity");
                                            if (quantity[index] == 0) {
                                              // itemQuantity++;
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();

                                              quantity[index]++;
                                              prefs.setInt("quantity_$index",
                                                  quantity[index]);
                                              prefs.getInt("quantity_$index");
                                              viewModel.itemId = data.id;
                                              cartItems.add({
                                                "userID": userDetails!.uid,
                                                "index": index,
                                                "itemID": data.id,
                                                "image": image,
                                                "itemName":
                                                    data.get("itemName"),
                                                "itemPrice":
                                                    data.get("itemPrice"),
                                                "itemRating":
                                                    data.get("itemRating"),
                                                "itemName_2":
                                                    data.get("itemName_2"),
                                                "itemDescription":
                                                    data.get("itemDescription"),
                                                "itemQuantity": quantity[index],
                                              });
                                              await viewModel.updateUser();
                                              // await FirebaseFirestore.instance.
                                              // await viewModel.updateAddItems(
                                              //     data.get("image"),
                                              //     data.get("itemName"),
                                              //     data.get("itemPrice"),
                                              //     data.get("itemRating"),
                                              //     data.get("itemName_2"),
                                              //     data.get("itemDescription"),
                                              //     itemQuantity,
                                              //     context);
                                              // await viewModel.addToCart(
                                              //     data.get("image"),
                                              //     data.get(
                                              //         "itemName".toString()),
                                              //     data.get(
                                              //         "itemPrice".toString()),
                                              //     data.get(
                                              //         "itemRating".toString()),
                                              //     data.get(
                                              //         "itemName_2".toString()),
                                              //     data.get("itemDescription"
                                              //         .toString()),
                                              //     itemQuantity,
                                              //     context);
                                              // cartImage = image;
                                              // data.get("itemQuantity") == "1";
                                              viewModel.rebuildUi();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Row(
                                                        children: [
                                                          Text("Already added"),
                                                        ],
                                                      )));
                                            }
                                          },
                                          width: getWidth(context, 0.8),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.mainTheme,
                                ),
                              );
                            }
                          }))
                ],
              ),
            ),
          );
        });
  }
}
