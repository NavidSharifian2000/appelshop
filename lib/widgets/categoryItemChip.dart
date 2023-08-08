import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryItemLIst extends StatelessWidget {
  const CategoryItemLIst({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: ShapeDecoration(
                color: Colors.red,
                shadows: [
                  BoxShadow(
                      color: Colors.red,
                      blurRadius: 40,
                      spreadRadius: -10,
                      offset: Offset(0, 10)),
                ],
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Icon(
              Icons.mouse,
              color: Colors.white,
              size: 32,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        const Text(
          "همه",
          style: TextStyle(fontFamily: "SB", fontSize: 12),
        )
      ]),
    );
  }
}
