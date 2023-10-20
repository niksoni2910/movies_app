import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/home_widgets/add_to_favourite.dart';
import 'package:movies_app/widgets/home_widgets/movie_image.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({
    super.key,
    required this.catalog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.end,
          buttonPadding: EdgeInsets.zero,
          children: [
            AddtoCart(
              catalog: catalog,
            ).wh(130, 50)
          ],
        ).p32(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
                tag: Key(catalog.title),
                child: MovieImage(
                  image: catalog.image,
                )),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  color: context.cardColor,
                  width: context.screenWidth,
                  child: Column(
                    children: [
                      catalog.title.text
                          .color(context.accentColor)
                          .xl2
                          .bold
                          .make()
                          .centered()
                          .p8(),
                      "Imdb rating: ${catalog.imdb}"
                          .text
                          .color(context.accentColor)
                          .xl
                          .bold
                          .make()
                          .centered()
                          .p8(),
                      "Year: ${catalog.year}"
                          .text
                          .color(context.accentColor)
                          .xl
                          .bold
                          .make()
                          .centered()
                          .p8(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: "${catalog.description}"
                              .text
                              .color(context.accentColor)
                              .xl
                              .make()
                              .p8(),
                        ),
                      )
                    ],
                  ).py32(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
