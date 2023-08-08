import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_fluter/bloc/authentication/auth_bloc.dart';
import 'package:shop_fluter/bloc/basket/basket_bloc.dart';
import 'package:shop_fluter/bloc/basket/basket_event.dart';
import 'package:shop_fluter/bloc/category/category_bloc.dart';
import 'package:shop_fluter/bloc/home/home_bloc.dart';
import 'package:shop_fluter/constant/Colors.dart';
import 'package:shop_fluter/data/datasource/authentication_datasource.dart';
import 'package:shop_fluter/data/model/Basket_item.dart';
import 'package:shop_fluter/data/repository/authentication_repository.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/screens/card_screen.dart';
import 'package:shop_fluter/screens/category_screen.dart';
import 'package:shop_fluter/screens/home_screens.dart';
import 'package:shop_fluter/screens/login_screen.dart';
import 'package:shop_fluter/screens/product_list_screen.dart';
import 'package:shop_fluter/screens/productdetail_screen.dart';
import 'package:shop_fluter/screens/profile_screen.dart';
import 'package:shop_fluter/util/aut_manager.dart';
import 'package:shop_fluter/widgets/ProductItem.dart';
import 'package:shop_fluter/widgets/sliderbanner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CardItemAdapter());
  await Hive.openBox<Basket_Item>("cardbox");
  await getInit();
  runApp(maineScreen());
}

class maineScreen extends StatefulWidget {
  maineScreen({super.key});

  @override
  State<maineScreen> createState() => _maineScreenState();
}

class _maineScreenState extends State<maineScreen> {
  int selectedscreen = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: IndexedStack(
        index: selectedscreen,
        children: getscreens(),
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: BottomNavigationBar(
              currentIndex: selectedscreen,
              onTap: (int index) {
                setState(() {
                  selectedscreen = index;
                });
              },
              elevation: 0,
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'sb', fontSize: 10, color: Colors.black),
              selectedLabelStyle: TextStyle(
                  fontFamily: 'sb',
                  fontSize: 10,
                  color: OurColor.andicatorcolor),
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/icon_profile.png"),
                  label: "حساب کاربری",
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child:
                          Image.asset("assets/images/icon_profile_active.png"),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: OurColor.andicatorcolor,
                            spreadRadius: -7,
                            blurRadius: 20,
                            offset: Offset(0.0, 13))
                      ]),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/icon_basket.png"),
                  label: "سبد خرید",
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child:
                          Image.asset("assets/images/icon_basket_active.png"),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: OurColor.andicatorcolor,
                            spreadRadius: -7,
                            blurRadius: 20,
                            offset: Offset(0.0, 13))
                      ]),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/icon_basket.png"),
                  label: "دسته بندی",
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child:
                          Image.asset("assets/images/icon_category_active.png"),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: OurColor.andicatorcolor,
                            spreadRadius: -7,
                            blurRadius: 20,
                            offset: Offset(0.0, 13))
                      ]),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset("assets/images/icon_home.png"),
                  label: "خانه ",
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child: Image.asset("assets/images/icon_home_active.png"),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: OurColor.andicatorcolor,
                            spreadRadius: -7,
                            blurRadius: 20,
                            offset: Offset(0.0, 13))
                      ]),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    ));
  }

  List<Widget> getscreens() {
    return <Widget>[
      ProfileScreen(),
      BlocProvider(
        create: ((context) {
          var bloc = locator.get<BasketBloc>();
          bloc.add(BasketFetchFromHiveEvent());
          return bloc;
        }),
        child: CardScreen(),
      ),
      BlocProvider(
          create: (context) => CategoryBloc(), child: Category_Screen()),
      Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => HomeBloc(),
          child: Home_Screen(),
        ),
      )
    ];
  }
}
