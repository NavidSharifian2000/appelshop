import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  CachedImage({super.key, this.imageUrl});
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: imageUrl!,
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
        ),
        placeholder: (context, Url) => Container(
          color: Colors.amber,
        ),
      ),
    );
  }
}
