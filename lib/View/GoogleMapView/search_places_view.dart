import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
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
    String KPLACES_API_KEY = "AIzaSyAbuVUCCOObkn_hV8u_l8_nMVcQ4stA6nM";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken $_sessionToken';

    var uri = Uri.parse(request);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
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
          ],
        ),
      ),
    );
  }
}
