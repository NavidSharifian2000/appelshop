import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/categoryProduct/categoryproduct_bloc.dart';
import 'package:shop_fluter/bloc/home/home_bloc.dart';
import 'package:shop_fluter/bloc/home/home_evenr.dart';
import 'package:shop_fluter/bloc/home/home_state.dart';
import 'package:shop_fluter/data/model/banner.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/data/model/product.dart';
import 'package:shop_fluter/data/repository/banner_repository.dart';
import 'package:shop_fluter/screens/category_screen.dart';
import 'package:shop_fluter/screens/product_list_screen.dart';
import 'package:shop_fluter/widgets/cacheimage.dart';

import '../constant/Colors.dart';
import '../widgets/ProductItem.dart';
import '../widgets/sliderbanner.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeInitData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OurColor.backgroundColorScreen,
      body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return CustomScrollView(
          slivers: [
            getsearchbox(),
            if (state is HomeLoadingState) ...[
              SliverToBoxAdapter(
                child: CircularProgressIndicator(),
              )
            ],
            if (state is HomeResponseState) ...[
              state.bannerList.fold((l) {
                return SliverToBoxAdapter(
                  child: Text("asdasd"),
                );
              }, (r) {
                return getbanners(
                  list: r,
                );
              }),
            ],
            getcategoryItemtitle(),
            if (state is HomeResponseState) ...[
              state.categoryList.fold((l) {
                return SliverToBoxAdapter(
                  child: Text(l),
                );
              }, (r) {
                return getcategoryList(
                  listcategory: r,
                );
              })
            ],
            getbestsellertitle(),
            if (state is HomeResponseState) ...[
              state.bestseller.fold((l) {
                return SliverToBoxAdapter(
                  child: SliverToBoxAdapter(child: Text("sdfsdfsdfsdf")),
                );
              }, (r) {
                return bestsellerproduct(
                  listproduct: r,
                );
              })
            ],
            mostviewedtitle(),
            if (state is HomeResponseState) ...[
              state.hotestproduclist.fold((l) {
                return Text(l);
              }, (r) {
                return getmostviewdproduct(
                  listproduct: r,
                );
              })
            ],
          ],
        );
      })),
    );
  }
}

class getmostviewdproduct extends StatelessWidget {
  List<MainProduct> listproduct;
  getmostviewdproduct({super.key, required this.listproduct});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listproduct.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(product: listproduct[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class mostviewedtitle extends StatelessWidget {
  const mostviewedtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 44, right: 44, bottom: 20, top: 39),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "پربازدید ترین ها",
              style:
                  TextStyle(fontFamily: "sm", fontSize: 12, color: Colors.grey),
            ),
            Spacer(),
            Text(
              "مشاهده همه",
              style: TextStyle(
                fontFamily: "sm",
                color: OurColor.andicatorcolor,
              ),
            ),
            Image.asset("assets/images/icon_left_categroy.png"),
          ],
        ),
      ),
    );
  }
}

class bestsellerproduct extends StatelessWidget {
  List<MainProduct> listproduct;
  bestsellerproduct({super.key, required this.listproduct});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listproduct.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ProductItem(
                  product: listproduct![index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class getbestsellertitle extends StatelessWidget {
  const getbestsellertitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 44, right: 44, bottom: 20),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "پرفروش ترین ها",
              style:
                  TextStyle(fontFamily: "sm", fontSize: 12, color: Colors.grey),
            ),
            Spacer(),
            Text(
              "مشاهده همه",
              style: TextStyle(
                fontFamily: "sm",
                color: OurColor.andicatorcolor,
              ),
            ),
            Image.asset("assets/images/icon_left_categroy.png"),
          ],
        ),
      ),
    );
  }
}

class getcategoryList extends StatelessWidget {
  List<MainCategory> listcategory;
  getcategoryList({super.key, required this.listcategory});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(right: 44),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listcategory.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoryItemLIst(
                category: listcategory[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

class getcategoryItemtitle extends StatelessWidget {
  const getcategoryItemtitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 44, left: 44, bottom: 20, top: 32),
            child: Text(
              "دسته بندی",
              style:
                  TextStyle(fontFamily: 'sb', fontSize: 12, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}

class getbanners extends StatelessWidget {
  List<MainBanner> list;
  getbanners({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(
        bannerList: list,
      ),
    );
  }
}

class getsearchbox extends StatelessWidget {
  const getsearchbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 44, left: 44, bottom: 32, top: 20),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 16,
              ),
              Image.asset("assets/images/icon_apple_blue.png"),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  "search",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "sm", fontSize: 16, color: Colors.grey),
                ),
              ),
              Image.asset("assets/images/icon_search.png"),
              SizedBox(
                width: 16,
              )
            ],
          ),
          height: 46,
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    );
  }
}

class CategoryItemLIst extends StatelessWidget {
  final MainCategory category;
  const CategoryItemLIst({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    String catgorycolor = category.color.toString();
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => categoryproductbloc(),
                    child: ProductListscreen(category),
                  )));
        },
        child: Column(children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: ShapeDecoration(
                  color: Color(int.parse("ff" + catgorycolor, radix: 16)),
                  shadows: [
                    BoxShadow(
                        color: Color(int.parse("ff" + catgorycolor, radix: 16)),
                        blurRadius: 40,
                        spreadRadius: -10,
                        offset: Offset(0, 10)),
                  ],
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: CachedImage(
                    imageUrl: category.icon,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            category.title!,
            style: TextStyle(fontFamily: "SB", fontSize: 12),
          )
        ]),
      ),
    );
  }
}
