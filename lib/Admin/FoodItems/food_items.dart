import 'package:flutter/material.dart';
import 'package:food_go/Admin/FoodItems/food_item_model.dart';
import 'package:food_go/utils/Widgets/TextFieldWidget/textfield_widget.dart';
import 'package:stacked/stacked.dart';

class FoodItems extends StatelessWidget {
  const FoodItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FoodItemModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Items"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    viewModel.selectedImage == null
                        ? InkWell(
                            onTap: () {
                              viewModel.getImage();
                            },
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all()),
                              child: const Center(
                                child: Icon(Icons.add),
                              ),
                            ),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all()),
                            child: Image.file(viewModel.selectedImage!)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Add Picture"),
                    const SizedBox(
                      height: 30,
                    ),
                    textField("Item Name", 1, viewModel.itemNameController),
                    const SizedBox(
                      height: 20,
                    ),
                    textField("Item Price", 1, viewModel.itemPriceController),
                    const SizedBox(
                      height: 20,
                    ),
                    textField(
                        "Item Quantity", 1, viewModel.itemQuantityController),
                    const SizedBox(
                      height: 20,
                    ),
                    textField("Item Description", 7,
                        viewModel.itemDescriptionController),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape:
                                  WidgetStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                              elevation: const WidgetStatePropertyAll(3),
                              backgroundColor:
                                  const WidgetStatePropertyAll(Colors.red)),
                          onPressed: () {
                            viewModel.addItems();
                          },
                          child: const Text(
                            "Add Product",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
