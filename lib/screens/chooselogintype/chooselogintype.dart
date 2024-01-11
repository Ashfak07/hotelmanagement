import 'package:flutter/material.dart';
import 'package:hotelmanagement/Chefapp/login/cheflogin.dart';
import 'package:hotelmanagement/screens/login_screen/login_screen.dart';
import 'package:hotelmanagement/utils/common/colorconstants/color_constants.dart';

class ChooseLoginType extends StatelessWidget {
  const ChooseLoginType({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
              width: mediaSize.width * 0.4,
              height: mediaSize.width * 0.12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: ColorConstants.bannerColor),
              child: Center(
                child: Text(
                  'Login as Admin',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChefLogin()));
            },
            child: Container(
              width: mediaSize.width * 0.4,
              height: mediaSize.width * 0.12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: ColorConstants.bannerColor),
              child: Center(
                child: Text(
                  'Login as chef',
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
