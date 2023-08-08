import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/basket/basket_bloc.dart';
import 'package:shop_fluter/bloc/product/product_bloc.dart';
import 'package:shop_fluter/data/model/product.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/screens/productdetail_screen.dart';
import 'package:shop_fluter/widgets/cacheimage.dart';

import '../constant/Colors.dart';

class ProductItem extends StatelessWidget {
  MainProduct product;
  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print(product.realprice);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<BasketBloc>.value(
              value: locator.get<BasketBloc>(),
              child: Product_detailsscreen(product),
            ),
          ),
        );
      },
      child: Container(
        height: 216,
        width: 160,
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(alignment: Alignment.center, children: [
              Expanded(child: Container()),
              SizedBox(
                width: 98,
                height: 98,
                child: CachedImage(
                  imageUrl: product.thumbnail,
                ),
              ),
              Positioned(
                top: 0,
                right: 10,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/images/active_fav_product.png"),
                ),
              ),
              Positioned(
                  left: 10,
                  bottom: 0,
                  child: Container(
                    child: Center(
                      child: Text(
                        product.persent!.round().toString() + "%",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "sb",
                            fontSize: 12),
                      ),
                    ),
                    width: 25,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ))
            ]),
            Spacer(),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 10),
                child: Text(
                  product.name,
                  maxLines: 1,
                  style: TextStyle(fontFamily: 'sm', fontSize: 14),
                ),
              ),
              Container(
                height: 53,
                decoration: BoxDecoration(
                  color: OurColor.andicatorcolor,
                  boxShadow: [
                    BoxShadow(
                        color: OurColor.andicatorcolor,
                        blurRadius: 25,
                        spreadRadius: -12,
                        offset: Offset(0.0, 15))
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "تومان",
                        style: TextStyle(
                            fontFamily: 'sm',
                            fontSize: 12,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            product.price.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'sm',
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Expanded(
                            child: Text(
                              product.realprice.toString(),
                              style: TextStyle(
                                fontFamily: 'sm',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        width: 19,
                        child: Image.asset(
                            "assets/images/icon_right_arrow_cricle.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
