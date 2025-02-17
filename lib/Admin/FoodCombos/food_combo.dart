import 'package:flutter/material.dart';
import 'package:food_go/Admin/FoodCombos/food_combo_model.dart';
import 'package:food_go/utils/Widgets/MyTextField/my_text_field.dart';
import 'package:stacked/stacked.dart';

class FoodCombo extends StatelessWidget {
  const FoodCombo({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FoodComboModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Food Combos"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    // viewModel.selectedImage == null
                    //     ? InkWell(
                    //         onTap: () {
                    //           viewModel.getImage();
                    //         },
                    //         child: Container(
                    //           height: 120,
                    //           width: 120,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(15),
                    //               border: Border.all()),
                    //           child: const Center(
                    //             child: Icon(Icons.add),
                    //           ),
                    //         ),
                    //       )
                    //     : Container(
                    //         height: 120,
                    //         width: 120,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(15),
                    //             border: Border.all()),
                    //         child: Image.file(viewModel.selectedImage!)),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const Text("Add Picture"),
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                        label: "Image Name",
                        maxLines: 1,
                        controller: viewModel.imageController),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                        label: "Item Name",
                        maxLines: 1,
                        controller: viewModel.itemNameController),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                        label: "Item Name 2",
                        maxLines: 1,
                        controller: viewModel.itemName_2Controller),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                        label: "Item Price",
                        maxLines: 1,
                        controller: viewModel.itemPriceController),
                    const SizedBox(
                      height: 20,
                    ),
                    // textField(
                    //     "Item Quantity", 1, viewModel.itemQuantityController),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    MyTextField(
                        label: "Item Rating",
                        maxLines: 1,
                        controller: viewModel.itemRatingController),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                        label: "Item Description",
                        maxLines: 7,
                        controller: viewModel.itemDescriptionController),
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
                            if (viewModel.itemNameController.text != "" &&
                                    viewModel.itemName_2Controller.text != "" &&
                                    viewModel.itemPriceController.text != "" &&
                                    viewModel.itemRatingController.text != "" &&
                                    viewModel.itemDescriptionController.text !=
                                        ""
                                //viewModel.selectedImage!.path != ""
                                ) {
                              viewModel.addItems();
                              Future.delayed(const Duration(seconds: 1), () {
                                viewModel.itemNameController.clear();
                                viewModel.itemName_2Controller.clear();
                                viewModel.itemPriceController.clear();
                                // viewModel.itemQuantityController.clear();
                                viewModel.itemRatingController.clear();
                                viewModel.itemDescriptionController.clear();
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please fill the Forms."),
                                backgroundColor: Colors.red,
                              ));
                            }
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
