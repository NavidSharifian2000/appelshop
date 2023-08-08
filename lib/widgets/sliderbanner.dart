import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_fluter/data/model/banner.dart';
import 'package:shop_fluter/widgets/cacheimage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant/Colors.dart';

class BannerSlider extends StatelessWidget {
  List<MainBanner> bannerList;
  BannerSlider({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.9);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
              itemCount: bannerList.length,
              controller: controller,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  child: CachedImage(
                    imageUrl: bannerList[index].thumbnail,
                  ),
                );
              }),
        ),
        Positioned(
            bottom: 8,
            child: SmoothPageIndicator(
              controller: controller, // PageController
              count: bannerList.length,
              effect: ExpandingDotsEffect(
                  expansionFactor: 5,
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: OurColor.andicatorcolor),
            ))
      ],
    );
  }
}
