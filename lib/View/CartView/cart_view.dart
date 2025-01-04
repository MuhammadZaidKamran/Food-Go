import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/CartViewModel/cart_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/CartContainerWidget/cart_container_widget.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CartViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Cart"),
              centerTitle: true,
            ),
            body: FutureBuilder(
                future: viewModel.userCart.doc(userDetails!.uid).get(),
                builder: (context, snapshot) {
                  return ListView.separated(
                      itemCount: snapshot.data?.get("cartItems").length ?? 0,
                      separatorBuilder: (context, index) => height(10),
                      itemBuilder: (context, index) {
                        final item =
                            snapshot.data?.get("cartItems")[index] ?? {};
                        if (snapshot.hasData) {
                          return CartContainerWidget(
                            image: item["image"],
                            itemName: item["itemName"],
                            itemQuantity: "${item["itemQuantity"]}",
                            itemPrice: item["itemPrice"],
                            onTapMinus: () {},
                            onTapPlus: () {},
                            onTapDelete: () {},
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainTheme,
                            ),
                          );
                        }
                      });
                }),
          );
        });
  }
}
