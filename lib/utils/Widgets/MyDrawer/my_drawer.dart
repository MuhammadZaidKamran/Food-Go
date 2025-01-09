import 'package:flutter/material.dart';
import 'package:food_go/View/EditProfileView/edit_profile_view.dart';
import 'package:food_go/utils/Colors/colors.dart';
import 'package:food_go/utils/Global/global.dart';
import 'package:food_go/utils/Widgets/DrawerListTile/drawer_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
          child: Column(
            children: [
              height(MediaQuery.of(context).size.height * 0.035),
              Row(
                children: [
                  ClipOval(
                      child: Image.asset(
                    "assets/images/google-icon.png",
                    scale: 7,
                  )),
                  width(getWidth(context, 0.02)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getWidth(context, 0.2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "User",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor),
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
                      ),
                      height(getHeight(context, 0.007)),
                      Text(
                        "user@gmail.com",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.whiteColor),
                      ),
                    ],
                  )
                ],
              ),
              height(getHeight(context, 0.03)),
              DrawerListTile(
                  title: "Home", icon: Icons.home_outlined, onTap: () {}),
              height(getHeight(context, 0.01)),
              DrawerListTile(
                  title: "Cart",
                  icon: Icons.shopping_bag_outlined,
                  onTap: () {}),
              height(getHeight(context, 0.01)),
              DrawerListTile(
                  title: "Favorites",
                  icon: Icons.favorite_border_outlined,
                  onTap: () {}),
              height(getHeight(context, 0.01)),
              DrawerListTile(
                  title: "Settings", icon: Icons.settings, onTap: () {}),
              height(getHeight(context, 0.01)),
              DrawerListTile(
                  title: "Profile",
                  icon: Icons.account_circle_outlined,
                  onTap: () {}),
              height(getHeight(context, 0.01)),
              DrawerListTile(
                  title: "About",
                  icon: Icons.info_outline_rounded,
                  onTap: () {}),
              height(getHeight(context, 0.15)),
              DrawerListTile(
                  title: "Logout", icon: Icons.logout_rounded, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
