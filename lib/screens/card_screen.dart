import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shop_fluter/bloc/basket/basket_bloc.dart';
import 'package:shop_fluter/bloc/basket/basket_state.dart';
import 'package:shop_fluter/constant/Colors.dart';
import 'package:shop_fluter/data/model/Basket_item.dart';
import 'package:shop_fluter/util/extentions/string_extentions.dart';
import 'package:shop_fluter/widgets/cacheimage.dart';
import 'package:zarinpal/zarinpal.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  PaymentRequest _paymentRequest = PaymentRequest();
  @override
  void initState() {
    super.initState();
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(1000);
    _paymentRequest.setDescription("this is for test appelshop");
    _paymentRequest.setCallbackURL("expertflutter://shop");
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Basket_Item>('CardBox');
    return Scaffold(
        backgroundColor: OurColor.backgroundColorScreen,
        body: SafeArea(child:
            BlocBuilder<BasketBloc, BasketState>(builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 44, left: 44, bottom: 32, top: 20),
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Image.asset("assets/images/icon_apple_blue.png"),
                            Expanded(
                              child: Text(
                                "سبد خرید",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontFamily: "sm",
                                    fontSize: 16,
                                    color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              width: 16,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  if (state is Basketinitstate) ...{
                    SliverToBoxAdapter(
                      child: CircularProgressIndicator(),
                    )
                  },
                  if (state is BasketDataFetchedState) ...{
                    state.basketItemlist.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (basketitems) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return cardItem(basketitems[index]);
                          },
                          childCount: basketitems.length,
                        ),
                      );
                    })
                  },
                  SliverPadding(padding: EdgeInsets.only(bottom: 50))
                ],
              ),
              if (state is BasketDataFetchedState) ...{
                if (state.basketfinalprice == 0) ...{
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 44, vertical: 10),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          ZarinPal().startPayment(_paymentRequest,
                              (status, paymentGatewayUri) => null);
                        },
                        child: Text(
                          "سبد خالی است",
                          style: TextStyle(fontFamily: 'sb', fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: OurColor.greencolor,
                        ),
                      ),
                    ),
                  )
                },
                if (state.basketfinalprice > 0) ...{
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 44, vertical: 10),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          state.basketfinalprice.toString(),
                          style: TextStyle(fontFamily: 'sb', fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: OurColor.greencolor,
                        ),
                      ),
                    ),
                  )
                }
              }
            ],
          );
        })));
  }
}

class cardItem extends StatelessWidget {
  Basket_Item basketItem;
  cardItem(
    this.basketItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 44, right: 44, bottom: 20),
      height: 249,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            basketItem.name,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontFamily: 'sb', fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "'گارانتی فیلان 18 ماهه",
                            style: TextStyle(fontFamily: 'sm', fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    "%3",
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "تومان",
                                style:
                                    TextStyle(fontFamily: 'sb', fontSize: 20),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                basketItem.price.toString(),
                                style:
                                    TextStyle(fontFamily: 'sb', fontSize: 20),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(spacing: 8, children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "حذف",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'sb',
                                          fontSize: 12),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset("assets/images/icon_trash.png")
                                  ],
                                ),
                              ),
                            ),
                            chipoptions("170ddb"),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 75,
                      width: 70,
                      child: CachedImage(imageUrl: basketItem.thumbnail))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DottedLine(
              lineThickness: 3.0,
              dashLength: 8,
              dashColor: Colors.grey.withOpacity(0.5),
              dashGapLength: 3.0,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("تومان", style: TextStyle(fontFamily: 'sb', fontSize: 15)),
                SizedBox(
                  width: 5,
                ),
                Text(
                  (basketItem.price + basketItem.discountPrice).toString(),
                  style: TextStyle(fontFamily: 'sb', fontSize: 15),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class chipoptions extends StatelessWidget {
  String color;
  chipoptions(
    this.color, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "آبی",
              style: TextStyle(fontFamily: 'sb', fontSize: 12),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: color.parsetocolor()),
            )
          ],
        ),
      ),
    );
  }
}
