import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_fluter/bloc/category/category_bloc.dart';
import 'package:shop_fluter/bloc/category/category_event.dart';
import 'package:shop_fluter/bloc/category/category_state.dart';
import 'package:shop_fluter/data/model/category.dart';
import 'package:shop_fluter/data/repository/category_repository.dart';
import 'package:shop_fluter/widgets/cacheimage.dart';

class Category_Screen extends StatefulWidget {
  const Category_Screen({super.key});

  @override
  State<Category_Screen> createState() => _Category_ScreenState();
}

class _Category_ScreenState extends State<Category_Screen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context as BuildContext)
        .add(CategoryRequestList());
    super.initState();
  }

  List<MainCategory>? list;
  @override
  Widget build(BuildContext context) {
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
                            Text("category"),
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
            BlocBuilder<CategoryBloc, CAtegoryState>(builder: (context, state) {
              if (state is CategoryLoadingState) {
                return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              }
              if (state is CategoryResponseState) {
                return state.Response.fold(
                  (l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  },
                  (r) {
                    return listcategory(listItem: r);
                  },
                );
              }
              return SliverToBoxAdapter(child: Text("error"));
            }),
          ],
        ),
      ),
    );
  }
}

class listcategory extends StatelessWidget {
  List<MainCategory>? listItem;
  listcategory({super.key, required this.listItem});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return CachedImage(
              imageUrl: listItem?[index].thumbnail ??
                  "http://startflutter.ir/api/files/f5pm8kntkfuwbn1/78q8w901e6iipuk/rectangle_63_7kADbEzuEo.png");
        }, childCount: 8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
      ),
    );
  }
}
