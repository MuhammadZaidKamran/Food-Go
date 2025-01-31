import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/OrderSuccessfulViewModel/order_successful_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/OrderSuccessfulWidget/order_successful_widget.dart';
import 'package:stacked/stacked.dart';

class OrderSuccessfulView extends StatelessWidget {
  const OrderSuccessfulView(
      {super.key,
      required this.orderId,
      required this.userId,
      required this.orderConfirmedList,
      // required this.status,
      required this.address,
      required this.platformFee,
      required this.deliveryCharges,
      required this.totalAmount,
      required this.note});
  final String orderId;
  final String userId;
  final List orderConfirmedList;
  // final int status;
  final String address;
  final String platformFee;
  final String deliveryCharges;
  final int totalAmount;
  final String note;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => OrderSuccessfulViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Order Details"),
            ),
            body: Padding(
              padding: myPadding(),
              child: Column(
                children: [
                  height(getHeight(context, 0.025)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Successfully!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Text("#$orderId",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  height(getHeight(context, 0.03)),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      // height: getHeight(context, 0.4),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.darkMainTheme)),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderConfirmedList.length,
                          separatorBuilder: (context, index) => Divider(
                                color: AppColors.darkMainTheme,
                                indent: 20,
                                endIndent: 20,
                              ),
                          itemBuilder: (context, index) {
                            final item = orderConfirmedList[index];
                            return ListTile(
                              leading: Image.asset(
                                "assets/images/${item["image"]}.png",
                              ),
                              title: Text(
                                "${item["itemName"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              subtitle: Text(
                                "Rs.${item["itemPrice"]}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              trailing: Text(
                                "x${item["itemQuantity"]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  height(getHeight(context, 0.05)),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: myPadding(),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(color: AppColors.darkMainTheme),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderSuccessfulWidget(
                              title: "Platform Charges",
                              amount: "Rs.$platformFee"),
                          height(getHeight(context, 0.025)),
                          OrderSuccessfulWidget(
                              title: "Delivery Charges",
                              amount: "Rs.$deliveryCharges"),
                          height(getHeight(context, 0.025)),
                          OrderSuccessfulWidget(
                            title: "Total Amount",
                            amount: "Rs.$totalAmount",
                          ),
                          height(getHeight(context, 0.04)),
                          const Text(
                            "Address :",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          height(getHeight(context, 0.015)),
                          Text(
                            address,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          note == ""
                              ? const SizedBox()
                              : height(getHeight(context, 0.025)),
                          note == ""
                              ? const SizedBox()
                              : const Text(
                                  "Note :",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                          note == ""
                              ? const SizedBox()
                              : height(getHeight(context, 0.015)),
                          note == ""
                              ? const SizedBox()
                              : Text(note,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.blackColor),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
