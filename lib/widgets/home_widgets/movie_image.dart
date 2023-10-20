import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieImage extends StatelessWidget {
  final String image;

  const MovieImage({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return Image.asset('assests/img/$image')
        .box
        .rounded
        .p8
        .color(context.canvasColor)
        .make()
        .p16()
        .wPCT(context: context, widthPCT: context.isMobile ? 40 : 20);
  }
}
