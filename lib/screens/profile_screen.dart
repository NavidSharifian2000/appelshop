import 'package:flutter/material.dart';
import 'package:shop_fluter/screens/home_screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Padding(
        padding:
            const EdgeInsets.only(right: 44, left: 44, bottom: 32, top: 20),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Expanded(child: Container()),
                    Text("حساب کاربری"),
                    Positioned(
                        left: 10,
                        child:
                            Image.asset("assets/images/icon_apple_blue.png")),
                  ],
                ),
              )
            ],
          ),
          height: 46,
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
      Text(
        "امیر احمد ادیبی",
        style: TextStyle(fontFamily: 'sb', fontSize: 16),
      ),
      Text(
        "09101194077",
        style: TextStyle(fontFamily: 'sm', fontSize: 16),
      ),
      SizedBox(
        height: 10,
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [],
          ),
        ),
      ),
      Spacer(),
      Text(
        "اپل شاپ",
        style: TextStyle(fontFamily: 'sm', fontSize: 10),
      ),
      Text("v-2", style: TextStyle(fontFamily: 'sm', fontSize: 10)),
      Text("instagram/navidsharifian79",
          style: TextStyle(fontFamily: 'sm', fontSize: 10))
    ])));
  }
}
