import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/OrderSuccessfulView/order_successful_view.dart';
import 'package:food_go/ViewModel/OrdersViewModel/orders_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:stacked/stacked.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.orderDetails.snapshots().listen((snapshot) {
          viewModel.displayOrderList = snapshot.docs.toList();
          viewModel.rebuildUi();
        });
      },
      viewModelBuilder: () => OrdersViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Orders"),
            centerTitle: true,
          ),
          body: Padding(
              padding: myPadding(),
              child: ListView.separated(
                itemCount: viewModel.displayOrderList.length,
                separatorBuilder: (context, index) =>
                    height(getHeight(context, 0.03)),
                itemBuilder: (context, index) {
                  DocumentSnapshot orderDetails =
                      viewModel.displayOrderList[index];
                  return Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Order No: #${orderDetails["orderId"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                          ),
                          height(getHeight(context, 0.01)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.blackColor,
                              ),
                              Expanded(
                                child: Text(
                                  orderDetails["address"].toString(),
                                  style: const TextStyle(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          height(getHeight(context, 0.01)),
                          MyButton(
                            borderRadius: BorderRadius.circular(10),
                            height: 40,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSuccessfulView(
                                      status: orderDetails["status"],
                                      date: orderDetails["date"],
                                      orderId: orderDetails["orderId"],
                                      userId: orderDetails["userID"],
                                      orderConfirmedList:
                                          orderDetails["orderItems"],
                                      address: orderDetails["address"],
                                      platformFee: orderDetails["platFormFee"],
                                      deliveryCharges:
                                          orderDetails["deliveryCharges"],
                                      totalAmount: orderDetails["totalAmount"],
                                      note: orderDetails["note"],
                                    ),
                                  ));
                            },
                            label: "View Order Details",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        );
      },
    );
  }
}
