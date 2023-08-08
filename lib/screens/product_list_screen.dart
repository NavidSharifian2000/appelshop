import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/category/category_bloc.dart';
import 'package:shop_fluter/bloc/categoryProduct/categoryproduct_bloc.dart';
import 'package:shop_fluter/bloc/categoryProduct/categoryproduct_event.dart';
import 'package:shop_fluter/bloc/categoryProduct/categoryproduct_state.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/widgets/ProductItem.dart';

class ProductListscreen extends StatefulWidget {
  MainCategory category;
  ProductListscreen(this.category, {super.key});

  @override
  State<ProductListscreen> createState() => _ProductListscreenState();
}

class _ProductListscreenState extends State<ProductListscreen> {
  @override
  void initState() {
    BlocProvider.of<categoryproductbloc>(context)
        .add(categoryProductInitialize(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<categoryproductbloc, categoryProductState>(
        builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 44, left: 44, bottom: 32, top: 20),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Expanded(child: Container()),
                              Text(widget.category.title!),
                              Positioned(
                                  left: 10,
                                  child: Image.asset(
                                      "assets/images/icon_apple_blue.png")),
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
              ),
              if (state is categoryProductResponsesuccessState) ...{
                state.productListBycategory.fold((l) {
                  return SliverToBoxAdapter(
                    child: Text("navid"),
                  );
                }, (productlist) {
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 44),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        //return ProductItem();
                        return ProductItem(product: productlist[index]);
                      }, childCount: productlist.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20),
                    ),
                  );
                })
              },
              if (state is categoryproductloadinState) ...{
                SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              }
            ],
          ),
        ),
      );
    });
  }
}
