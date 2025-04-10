import 'package:flutter/material.dart';
import 'package:food_go/View/BottomNavBarView/bottom_nav_bar_view.dart';
import 'package:food_go/ViewModel/FavoriteViewModel/favorite_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({
    super.key,
    this.goBack = false,
  });
  final bool? goBack;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          for (int i = 0;
              i < isFavoriteList.length && i < isFavoriteCombos.length;
              i++) {
            isFavoriteList[i] = prefs.getBool("isFavorite_$i") ?? false;
            isFavoriteCombos[i] = prefs.getBool("isFavorite2_$i") ?? false;
          }
        },
        viewModelBuilder: () => FavoriteViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              leading: goBack == true
                  ? InkWell(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavBarView())),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.blackColor,
                      ),
                    )
                  : null,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text("Favorites"),
            ),
            body: FutureBuilder(
                future: viewModel.userFavorites.doc(userDetails!.uid).get(),
                builder: (context, snapshot) {
                  return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          height(getHeight(context, 0.02)),
                      itemCount:
                          snapshot.data?.get("favoriteItems").length ?? 0,
                      itemBuilder: (context, index) {
                        final item =
                            snapshot.data?.get("favoriteItems")[index] ?? {};
                        if (snapshot.hasData) {
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
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                                final isFavoriteCombo = prefs.getBool("isFavorite2_${item["index"]}");
                                        if (isFavoriteCombo ==
                                            true) {
                                          prefs.setBool(
                                              "isFavorite2_${item["index"]}",
                                              false);
                                          isFavoriteCombos[
                                              item[
                                                  "index"]] = prefs.getBool(
                                              "isFavorite2_${item["index"]}")!;
                                          favoriteItems.removeWhere((e) =>
                                              e["itemID"] == item["itemID"]);
                                          await viewModel.removeFavorite(
                                              // ignore: use_build_context_synchronously
                                              context: context);
                                          await viewModel.updateUser(
                                              // ignore: use_build_context_synchronously
                                              context: context);
                                        } else {
                                          prefs.setBool(
                                              "isFavorite_${item["index"]}",
                                              false);
                                          isFavoriteList[
                                              item[
                                                  "index"]] = prefs.getBool(
                                              "isFavorite_${item["index"]}")!;
                                          favoriteItems.removeWhere((e) =>
                                              e["itemID"] == item["itemID"]);
                                          await viewModel.removeFavorite(
                                              // ignore: use_build_context_synchronously
                                              context: context);
                                          await viewModel.updateUser(
                                              // ignore: use_build_context_synchronously
                                              context: context);
                                        }
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
                        } else {
                          return const Center(
                            child: Text("No Items Found"),
                          );
                        }
                      });
                }),
          );
        });
  }
}
