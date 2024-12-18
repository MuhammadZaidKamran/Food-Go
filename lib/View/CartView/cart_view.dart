import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/CartViewModel/cart_view_model.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CartViewModel(),
        builder: (context, viewModel, child) {
          return const Scaffold();
        });
  }
}
