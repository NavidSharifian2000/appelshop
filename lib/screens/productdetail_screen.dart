import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_fluter/bloc/basket/basket_bloc.dart';
import 'package:shop_fluter/bloc/basket/basket_event.dart';
import 'package:shop_fluter/bloc/home/home_state.dart';
import 'package:shop_fluter/bloc/product/product_bloc.dart';
import 'package:shop_fluter/bloc/product/product_event.dart';
import 'package:shop_fluter/bloc/product/product_state.dart';
import 'package:shop_fluter/constant/Colors.dart';
import 'package:shop_fluter/data/model/Basket_item.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/data/model/product.dart';
import 'package:shop_fluter/data/model/product_inages.dart';
import 'package:shop_fluter/data/model/product_property.dart';
import 'package:shop_fluter/data/model/product_variant.dart';
import 'package:shop_fluter/data/model/variant.dart';
import 'package:shop_fluter/data/model/variant_type.dart';
import 'package:shop_fluter/data/repository/productDetail_repository.dart';
import 'package:shop_fluter/di/di.dart';
import 'package:shop_fluter/widgets/ProductItem.dart';
import 'package:shop_fluter/widgets/cacheimage.dart';

class Product_detailsscreen extends StatefulWidget {
  MainProduct product;
  Product_detailsscreen(this.product, {super.key});

  @override
  State<Product_detailsscreen> createState() => _Product_detailsscreenState();
}

class _Product_detailsscreenState extends State<Product_detailsscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = productbloc();
        bloc.add(ProductInitEvent(widget.product.id, widget.product.category));
        return bloc;
      },
      child: DetailContentwidget(widget),
    );
  }
}

class DetailContentwidget extends StatelessWidget {
  const DetailContentwidget(this.parentwidget, {super.key});
  final Product_detailsscreen parentwidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<productbloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                if (state is productloadingstate) ...{
                  SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                },
                if (state is productResponsestate) ...{
                  state.productcategory.fold((l) {
                    return SliverToBoxAdapter(child: Text("navid"));
                  }, (r) {
                    return SliverToBoxAdapter(
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
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        r.title.toString(),
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontFamily: "sm",
                                            fontSize: 16,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ]),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Image.asset("assets/images/icon_back.png"),
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
                    );
                  })
                },
                SliverToBoxAdapter(
                  child: Text(
                    parentwidget.product.name,
                    style: TextStyle(fontFamily: 'sm', fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (state is productResponsestate) ...{
                  state.getproductImage.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text("sdad"),
                    );
                  }, (r) {
                    return gallerywidget(parentwidget.product.thumbnail, r);
                  })
                },
                if (state is productResponsestate) ...{
                  state.getproductvariants.fold((l) {
                    return Text(l.toString());
                  }, (productvariantlistt) {
                    return VariantContainerGenerator(productvariantlistt);
                  })
                },
                if (state is productResponsestate) ...{
                  state.properties.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text("navid"),
                    );
                  }, (r) {
                    return productproperties(r);
                  })
                },
                productdiscription(parentwidget.product.description),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 44, right: 44, top: 20),
                    height: 46,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Image.asset("assets/images/icon_left_categroy.png"),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "مشاهده",
                            style: TextStyle(
                                fontFamily: 'sb',
                                fontSize: 12,
                                color: Colors.blue),
                          ),
                          Spacer(),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                              Positioned(
                                right: 15,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                              Positioned(
                                right: 30,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                              Positioned(
                                right: 45,
                                child: Container(
                                  width: 26,
                                  height: 26,
                                  child: Center(
                                    child: Text(
                                      "+10",
                                      style: TextStyle(
                                          fontFamily: "sb",
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "نظرات کاربران",
                            style: TextStyle(fontFamily: 'sb'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 20),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        addtobasketbuttom(),
                        pricetag(parentwidget.product)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class productproperties extends StatefulWidget {
  List<Property> propertieslist;
  productproperties(
    this.propertieslist, {
    super.key,
  });

  @override
  State<productproperties> createState() => _productpropertiesState();
}

class _productpropertiesState extends State<productproperties> {
  bool disiable = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(children: [
      GestureDetector(
        onTap: () {
          setState(() {
            disiable = !disiable;
          });
        },
        child: Container(
          margin: EdgeInsets.only(left: 44, right: 44, top: 20),
          height: 46,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.asset("assets/images/icon_left_categroy.png"),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "مشاهده",
                  style: TextStyle(
                      fontFamily: 'sb', fontSize: 12, color: Colors.blue),
                ),
                Spacer(),
                Text(
                  "مشخصات فنی",
                  style: TextStyle(fontFamily: 'sb'),
                ),
              ],
            ),
          ),
        ),
      ),
      Visibility(
        visible: disiable,
        child: Container(
            margin: EdgeInsets.only(left: 44, right: 44, top: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.propertieslist.length,
                    itemBuilder: (context, index) {
                      var property = widget.propertieslist[index];
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                property.title + ":" + property.value,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    }))),
      )
    ]));
  }
}

class productdiscription extends StatefulWidget {
  String description;
  productdiscription(
    this.description, {
    super.key,
  });

  @override
  State<productdiscription> createState() => _productdiscriptionState();
}

class _productdiscriptionState extends State<productdiscription> {
  bool isdisable = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isdisable = !isdisable;
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 44, right: 44, top: 20),
            height: 46,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Image.asset("assets/images/icon_left_categroy.png"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "مشاهده",
                    style: TextStyle(
                        fontFamily: 'sb', fontSize: 12, color: Colors.blue),
                  ),
                  Spacer(),
                  Text(
                    "توضیحات محصول",
                    style: TextStyle(fontFamily: 'sb'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: isdisable,
          child: Container(
            margin: EdgeInsets.only(left: 44, right: 44, top: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.description,
                  style: TextStyle(fontSize: 16, fontFamily: "sm", height: 2),
                  textAlign: TextAlign.right,
                )),
          ),
        ),
      ],
    ));
  }
}

class VariantContainerGenerator extends StatelessWidget {
  List<productVAriant> productvariantlist;
  VariantContainerGenerator(
    this.productvariantlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        for (var productvariant in productvariantlist) ...{
          if (productvariant.variantlist.isNotEmpty) ...{
            variantGeneratorChild(productvariant)
          }
        }
      ],
    ));
  }
}

class variantGeneratorChild extends StatelessWidget {
  productVAriant productvariant;
  variantGeneratorChild(this.productvariant, {super.key});

  @override
  Widget build(BuildContext context) {
    print(productvariant.variantType.type);
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productvariant.variantType.title.toString(),
            style: TextStyle(fontFamily: 'sm'),
          ),
          SizedBox(
            height: 10,
          ),
          if (productvariant.variantType.type == varianttypeenum.storage) ...{
            storagevariantlist(productvariant.variantlist)
          },
          if (productvariant.variantType.type == varianttypeenum.color) ...{
            colorvariantlist(productvariant.variantlist)
          }
        ],
      ),
    );
  }
}

class gallerywidget extends StatefulWidget {
  String defultProductthumnail;
  List<MainproductImage> listimage;
  int selecteditem = 0;
  gallerywidget(
    this.defultProductthumnail,
    this.listimage, {
    super.key,
  });

  @override
  State<gallerywidget> createState() => _gallerywidgetState();
}

class _gallerywidgetState extends State<gallerywidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 44,
          right: 44,
        ),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/icon_star.png"),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "4.6",
                            style: TextStyle(fontFamily: 'sm', fontSize: 12),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 190,
                            width: 200,
                            child: CachedImage(
                              imageUrl: (widget.listimage.isEmpty)
                                  ? widget.defultProductthumnail
                                  : widget
                                      .listimage[widget.selecteditem].imageurl,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Image.asset("assets/images/icon_favorite_deactive.png"),
                    ],
                  ),
                ),
              ),
              if (widget.listimage.isNotEmpty) ...{
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: SizedBox(
                    height: 70,
                    child: ListView.builder(
                        itemCount: widget.listimage.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.selecteditem = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              padding: EdgeInsets.all(2),
                              height: 70,
                              width: 70,
                              child: CachedImage(
                                imageUrl: widget.listimage[index].imageurl,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                            ),
                          );
                        }),
                  ),
                ),
              },
              SizedBox(
                height: 10,
              )
            ],
          ),
          height: 284,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    );
  }
}

class addtobasketbuttom extends StatelessWidget {
  const addtobasketbuttom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
              color: OurColor.greencolor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "تومان",
                    style: TextStyle(
                        fontFamily: 'sm', fontSize: 12, color: Colors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "29,800,000",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'sm',
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough),
                      ),
                      Text(
                        "48,800,000",
                        style: TextStyle(
                          fontFamily: 'sm',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              height: 53,
              width: 160,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          ),
        )
      ],
    );
  }
}

class pricetag extends StatelessWidget {
  MainProduct product;
  pricetag(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 60,
          width: 140,
          decoration: BoxDecoration(
              color: OurColor.andicatorcolor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        GestureDetector(
          onTap: () {
            context.read<productbloc>().add(ProductAddToBasket(product));
            context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                child: Center(
                    child: Text(
                  "افزودن سبد خرید",
                  style: TextStyle(
                      fontFamily: 'sb', fontSize: 16, color: Colors.white),
                )),
                height: 53,
                width: 160,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class colorvariantlist extends StatefulWidget {
  List<variant> variantlist;
  colorvariantlist(this.variantlist, {super.key});

  @override
  State<colorvariantlist> createState() => _colorvariantlistState();
}

class _colorvariantlistState extends State<colorvariantlist> {
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.variantlist.length,
            itemBuilder: (context, index) {
              int color =
                  int.parse("ff" + widget.variantlist[index].value!, radix: 16);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedindex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                      border: (selectedindex == index)
                          ? Border.all(
                              width: 7,
                              color: Colors.white,
                              strokeAlign: BorderSide.strokeAlignOutside)
                          : Border.all(width: 2, color: Colors.white),
                      color: Color(color),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              );
              ;
            }),
      ),
    );
  }
}

class storagevariantlist extends StatefulWidget {
  List<variant> storagevariantList;
  storagevariantlist(this.storagevariantList, {super.key});

  @override
  State<storagevariantlist> createState() => _storagevariantlistState();
}

class _storagevariantlistState extends State<storagevariantlist> {
  int selectedindex2 = 0;
  @override
  Widget build(BuildContext context) {
    int selectedindex = 0;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.storagevariantList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedindex2 = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 25,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: (selectedindex2 == index)
                          ? Border.all(color: Colors.black, width: 2)
                          : Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: Text(
                      widget.storagevariantList[index].value!,
                      style: TextStyle(fontFamily: "sm", fontSize: 12),
                    )),
                  ),
                ),
              );
              ;
            }),
      ),
    );
  }
}
