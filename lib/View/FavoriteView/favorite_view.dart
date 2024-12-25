import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/FavoriteViewModel/favorite_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) {
          //viewModel.updateUser(context: context);
        },
        viewModelBuilder: () => FavoriteViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text("Favorites"),
            ),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("favoriteItems")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          height(getHeight(context, 0.02)),
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot item =
                            snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Material(
                            elevation: 6,
                            borderRadius: BorderRadius.circular(15),
                            child: ListTile(
                              tileColor: AppColors.whiteColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              leading: Image.asset(
                                "assets/images/${item["image"]}.png",
                                height: getHeight(
                                  context,
                                  0.08,
                                ),
                                width: getWidth(context, 0.16),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    item["itemName"].toString(),
                                    style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () async {
                                      viewModel.itemId = item.id;
                                      favoriteItems.removeWhere(
                                          (e) => e["itemID"] == item["itemID"]);
                                      await viewModel.removeFavorite(
                                          context: context);
                                      await viewModel.updateUser(
                                          // ignore: use_build_context_synchronously
                                          context: context);
                                      // await viewModel.updateFavorites(
                                      //     image: item["image"],
                                      //     itemName: item["itemName"],
                                      //     itemPrice: item["itemPrice"],
                                      //     itemRating: item["itemRating"],
                                      //     itemName_2: item["itemName_2"],
                                      //     itemDescription:
                                      //         item["itemDescription"],
                                      //     isFavorite: false,
                                      //     // ignore: use_build_context_synchronously
                                      //     context: context);
                                      viewModel.rebuildUi();
                                    },
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: AppColors.mainTheme,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.yellowColor,
                                    size: 18,
                                  ),
                                  width(getWidth(context, 0.01)),
                                  Text(
                                    item["itemRating"].toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Rs.${item["itemPrice"].toString()}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          );
        });
  }
}
