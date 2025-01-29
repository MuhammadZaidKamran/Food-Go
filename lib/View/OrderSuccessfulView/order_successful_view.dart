import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/OrderSuccessfulViewModel/order_successful_view_model.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:stacked/stacked.dart';

class OrderSuccessfulView extends StatelessWidget {
  const OrderSuccessfulView({super.key});

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
              child: const Column(
                children: [],
              ),
            ),
          );
        });
  }
}
