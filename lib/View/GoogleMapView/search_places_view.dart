import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchPlacesView extends StatefulWidget {
  const SearchPlacesView({super.key});

  @override
  State<SearchPlacesView> createState() => _SearchPlacesViewState();
}

class _SearchPlacesViewState extends State<SearchPlacesView> {
  final searchController = TextEditingController();
  String _sessionToken = "12334";
  Uuid uuid = const Uuid();
  List<dynamic> placesList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      onChange();
    });
  }

  onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(searchController.text);
  }

  getSuggestion(String input) async {
    String KPLACES_API_KEY = "AlzaSy2srmxjOrT8yyYdkktGU_W199VaEUGWxiK";
    String baseURL = 'https://maps.gomaps.pro/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken $_sessionToken';

    var uri = Uri.parse(request);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        debugPrint(response.body.toString());
        placesList = jsonDecode(response.body.toString())["predictions"];
      });
    } else {
      debugPrint("Failed to load predictions");
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Places"),
        centerTitle: true,
      ),
      body: Padding(
        padding: myPadding(),
        child: Column(
          children: [
            TextFormField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Places",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkMainTheme),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkMainTheme),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            height(getHeight(context, 0.02)),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    height(getHeight(context, 0.01)),
                itemCount: placesList.length,
                itemBuilder: (context, index) {
                  final data = placesList[index];
                  return ListTile(
                    onTap: () async {
                      List<Location> locations =
                          await locationFromAddress(data["description"]);
                      Navigator.pop(context, locations.first);
                      setState(() {});
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: AppColors.whiteColor,
                    leading: const Icon(Icons.location_on),
                    title: Text(
                      data["structured_formatting"]["main_text"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                    subtitle: Text(data["description"]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
