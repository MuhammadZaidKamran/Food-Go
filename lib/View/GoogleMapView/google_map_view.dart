import 'package:flutter/material.dart';
import 'package:food_go/ViewModel/GoogleMapViewModel/google_map_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) {
          viewModel.getCurrentLocation();
        },
        viewModelBuilder: () => GoogleMapViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: viewModel.initialPosition,
                  onMapCreated: (controller) {
                    viewModel.googleMapController.complete(controller);
                  },
                  markers: Set<Marker>.of(viewModel.markers),
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  mapType: MapType.normal,
                ),
                Positioned(
                    left: getWidth(context, 0.06),
                    top: getHeight(context, 0.06),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.mainTheme,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 15,
                    ),
                    height: getHeight(context, 0.25),
                    width: getWidth(context, 1),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Set Location",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor),
                        ),
                        height(getHeight(context, 0.02)),
                        TextField(
                          controller: viewModel.searchController,
                          decoration: InputDecoration(
                            hintText: "Search Location",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: AppColors.blackColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        height(getHeight(context, 0.02)),
                        MyButton(onTap: () {}, label: "Confirm Address")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
