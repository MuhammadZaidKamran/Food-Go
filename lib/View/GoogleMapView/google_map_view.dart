// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_go/View/GoogleMapView/search_places_view.dart';
import 'package:food_go/ViewModel/GoogleMapViewModel/google_map_view_model.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/MyButton/my_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key,required this.isReceive});
  final bool isReceive;

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
                    height: getHeight(context, 0.3),
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
                          "Confirm Address",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor),
                        ),
                        height(getHeight(context, 0.02)),
                        TextField(
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                          readOnly: true,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          onTap: () async {
                            var data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchPlacesView()));
                            if (data != null) {
                              viewModel.isReceive = true;
                              debugPrint(viewModel.isReceive.toString());
                              viewModel.newCameraPosition = data;
                              debugPrint(
                                  viewModel.newCameraPosition.toString());
                              final controller =
                                  await viewModel.googleMapController.future;
                              List<Placemark> placeMarks =
                                  await placemarkFromCoordinates(
                                      viewModel.newCameraPosition!.latitude,
                                      viewModel.newCameraPosition!.longitude);
                              viewModel.markers.add(
                                Marker(
                                  markerId: const MarkerId("3"),
                                  position: LatLng(
                                    viewModel.newCameraPosition!.latitude,
                                    viewModel.newCameraPosition!.longitude,
                                  ),
                                  infoWindow: InfoWindow(
                                    title:
                                        "${placeMarks.first.street}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality}, ${placeMarks.first.postalCode}, ${placeMarks.first.country}, ${placeMarks.first.thoroughfare}, ${placeMarks.first.subThoroughfare}",
                                  ),
                                ),
                              );
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(
                                          viewModel.newCameraPosition!.latitude,
                                          viewModel
                                              .newCameraPosition!.longitude),
                                      zoom: 14)));
                              viewModel.searchController.text =
                                  "${placeMarks.first.street}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality}, ${placeMarks.first.postalCode}, ${placeMarks.first.country}, ${placeMarks.first.thoroughfare}, ${placeMarks.first.subThoroughfare}";
                              viewModel.rebuildUi();
                            }
                          },
                          controller: viewModel.searchController,
                          decoration: InputDecoration(
                            hintText: "Search Location",
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: AppColors.blackColor,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.darkMainTheme)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.darkMainTheme)),
                          ),
                        ),
                        height(getHeight(context, 0.02)),
                        Expanded(
                          child: ListView.separated(
                            itemCount: viewModel.optionList.length,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                width(getWidth(context, 0.04)),
                            itemBuilder: (context, index) {
                              final data = viewModel.optionList[index];
                              return GestureDetector(
                                onTap: () {
                                  viewModel.selectedIndex = index;
                                  viewModel.rebuildUi();
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    width: getWidth(context, 0.2),
                                    height: getHeight(context, 0.06),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: viewModel.selectedIndex == index
                                          ? AppColors.darkMainTheme
                                          : AppColors.whiteColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        data.toString(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            color:
                                                viewModel.selectedIndex == index
                                                    ? AppColors.whiteColor
                                                    : AppColors.darkMainTheme),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        height(getHeight(context, 0.02)),
                        MyButton(
                            onTap: () async {
                              if (viewModel.isReceive) {
                                List<Placemark> placeMarks =
                                    await placemarkFromCoordinates(
                                        viewModel.newCameraPosition!.latitude,
                                        viewModel.newCameraPosition!.longitude);
                                viewModel.addUserDeliveryAddress(
                                  address:
                                      "${placeMarks.first.street}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality}, ${placeMarks.first.postalCode}, ${placeMarks.first.country}, ${placeMarks.first.thoroughfare}, ${placeMarks.first.subThoroughfare}",
                                  latitude:
                                      viewModel.newCameraPosition!.latitude,
                                  longitude:
                                      viewModel.newCameraPosition!.longitude,
                                  destination: viewModel.selectedIndex == 0
                                      ? "Home"
                                      : viewModel.selectedIndex == 1
                                          ? "Work"
                                          : "Other",
                                  context: context,
                                );
                              } else {
                                List<Location> location =
                                    await locationFromAddress(
                                        viewModel.searchController.text);
                                List<Placemark> placeMark =
                                    await placemarkFromCoordinates(
                                        location.first.latitude,
                                        location.first.longitude);
                                viewModel.addUserDeliveryAddress(
                                  address:
                                      "${placeMark.first.street}, ${placeMark.first.subLocality}, ${placeMark.first.locality}, ${placeMark.first.postalCode}, ${placeMark.first.country}, ${placeMark.first.thoroughfare}, ${placeMark.first.subThoroughfare}",
                                  latitude: location.first.latitude,
                                  longitude: location.first.longitude,
                                  destination: viewModel.selectedIndex == 0
                                      ? "Home"
                                      : viewModel.selectedIndex == 1
                                          ? "Work"
                                          : "Other",
                                  context: context,
                                );
                              }
                              viewModel.rebuildUi();
                            },
                            label: "Confirm Address")
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
