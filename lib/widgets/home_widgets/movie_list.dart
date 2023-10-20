// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/pages/home_detail_page.dart';
import 'package:movies_app/widgets/home_widgets/movie_image.dart';
import 'package:velocity_x/velocity_x.dart';

import 'add_to_favourite.dart';

class MovieList extends StatefulWidget {
  final String selectedFilter;
  const MovieList({
    super.key,
    required this.selectedFilter,
  });

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  bool _isLoading = false;
  void _sortItems() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      if (widget.selectedFilter == 'Year') {
        MovieModel.items.sort((a, b) => a.year.compareTo(b.year));
      } else if (widget.selectedFilter == 'IMDb') {
        MovieModel.items.sort((a, b) => a.imdb.compareTo(b.imdb));
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sortItems();
  }

  @override
  void didUpdateWidget(covariant MovieList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sortItems();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildList(),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildList() {
    return !context.isMobile
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20),
            shrinkWrap: true,
            itemCount: MovieModel.items.length,
            itemBuilder: (context, index) {
              final catalog = MovieModel.items[index];
              return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeDetailPage(
                                catalog: catalog,
                              ))),
                  child: MovieItem(catalog: catalog));
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: MovieModel.items.length,
            itemBuilder: (context, index) {
              final catalog = MovieModel.items[index];
              return InkWell(
                  onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeDetailPage(
                                      catalog: catalog,
                                    ))),
                      },
                  child: MovieItem(catalog: catalog));
            },
          );
  }
}

class MovieItem extends StatelessWidget {
  final Item catalog;

  const MovieItem({super.key, required this.catalog});
  @override
  Widget build(BuildContext context) {
    var children2 = [
      Hero(
          tag: Key(catalog.title.toString()),
          child: MovieImage(
            image: catalog.image,
          )),
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.title.text.lg.color(context.accentColor).bold.make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "${catalog.imdb}".text.xl.bold.make(),
                AddtoCart(catalog: catalog)
              ],
            ).pOnly(right: 8)
          ],
        ).p(context.isMobile ? 0 : 16),
      )
    ];
    return VxBox(
            child: context.isMobile
                ? Row(
                    children: children2,
                  )
                : Column(
                    children: children2,
                  ))
        .color(context.cardColor)
        .roundedLg
        .square(150)
        .make()
        .py16();
  }
}
