import 'package:flutter/material.dart';
import 'package:food_go/View/OrdersView/cancelled_tab.dart';
import 'package:food_go/View/OrdersView/completed_tab.dart';
import 'package:food_go/View/OrdersView/pending_tab.dart';
import 'package:food_go/ViewModel/OrdersViewModel/orders_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => OrdersViewModel(),
        builder: (context, viewModel, child) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                      Size(getWidth(context, 1), getHeight(context, 0.1)),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height(getHeight(context, 0.032)),
                        SizedBox(
                          width: getWidth(context, 0.54),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back),
                              ),
                              Text(
                                "Orders",
                                style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        height(getHeight(context, 0.015)),
                        TabBar(
                          indicatorColor: AppColors.darkMainTheme,
                          labelColor: AppColors.darkMainTheme,
                          dividerHeight: 0,
                          tabs: const [
                            Tab(
                              text: "Pending",
                            ),
                            Tab(
                              text: "Cancelled",
                            ),
                            Tab(
                              text: "Completed",
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              body: Padding(
                padding: myPadding(),
                child: const TabBarView(children: [
                  PendingTab(),
                  CancelledTab(),
                  CompletedTab(),
                ]),
              ),
            ),
          );
        });
  }
}
