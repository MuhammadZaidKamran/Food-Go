import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go/View/AboutUsView/about_us_view.dart';
import 'package:food_go/View/AddressView/address_view.dart';
import 'package:food_go/View/CartView/cart_view.dart';
import 'package:food_go/View/EditProfileView/edit_profile_view.dart';
import 'package:food_go/View/FavoriteView/favorite_view.dart';
import 'package:food_go/View/LoginView/login_view.dart';
import 'package:food_go/View/OrdersView/orders_view.dart';
import 'package:food_go/View/ProfileView/profile_view.dart';
import 'package:food_go/View/TermsAndConditionsView/terms_and_conditions_view.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/DrawerListTile/drawer_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? name;
  String? email;

  myInitMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("userName");
    email = prefs.getString("email");
    setState(() {});
  }

  @override
  void initState() {
    myInitMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: getWidth(context, 0.7),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/drawer.jpg",
              ),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          decoration:
              BoxDecoration(color: AppColors.darkMainTheme.withOpacity(0.9)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                height(MediaQuery.of(context).size.height * 0.035),
                Row(
                  children: [
                    ClipOval(
                      child: Icon(
                        Icons.account_circle,
                        color: AppColors.whiteColor,
                        size: 70,
                      ),
                    ),
                    width(getWidth(context, 0.02)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: getWidth(context, 0.18),
                              child: Text(
                                name.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteColor),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileView()));
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        height(getHeight(context, 0.007)),
                        Text(
                          email.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor),
                        ),
                      ],
                    )
                  ],
                ),
                height(getHeight(context, 0.02)),
                // height(getHeight(context, 0.01)),
                DrawerListTile(
                    title: "Cart",
                    icon: Icons.shopping_bag_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartView(
                                    goBack: true,
                                  )));
                    }),
                // height(getHeight(context, 0.01)),
                DrawerListTile(
                    title: "Favorites",
                    icon: Icons.favorite_border_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavoriteView(
                                    goBack: true,
                                  )));
                    }),
                DrawerListTile(
                    title: "Address",
                    icon: Icons.location_on,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddressView()));
                    }),
                DrawerListTile(
                    title: "Orders",
                    icon: Icons.shopping_cart_outlined,
                    onTap: () {
                      //
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrdersView()));
                    }),
                // height(getHeight(context, 0.01)),
                DrawerListTile(
                    title: "Settings", icon: Icons.settings, onTap: () {}),
                // height(getHeight(context, 0.01)),
                DrawerListTile(
                    title: "Profile",
                    icon: Icons.account_circle_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileView(
                                    goBack: true,
                                  )));
                    }),
                DrawerListTile(
                    title: "Terms & Conditions",
                    icon: Icons.align_vertical_bottom_sharp,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TermsAndConditionsView()));
                    }),
                // height(getHeight(context, 0.01)),
                DrawerListTile(
                    title: "About Us",
                    icon: Icons.info_outline_rounded,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUsView()));
                    }),
                height(getHeight(context, 0.15)),
                DrawerListTile(
                    title: "Logout",
                    icon: Icons.logout_rounded,
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) async {
                        // SharedPreferences prefs =
                        //     await SharedPreferences.getInstance();
                        // await prefs.clear();
                        Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()));
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
