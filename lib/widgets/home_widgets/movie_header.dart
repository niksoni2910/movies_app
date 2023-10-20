import 'package:flutter/material.dart';
import 'package:movies_app/widgets/home_widgets/movie_list.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/movie.dart';
import '../../pages/home_detail_page.dart';

class MovieHeader extends StatefulWidget {
  const MovieHeader({super.key});

  @override
  State<MovieHeader> createState() => _MovieHeaderState();
}

class _MovieHeaderState extends State<MovieHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Movies App"
            .text
            .xl5
            .bold
            .color(context.theme.colorScheme.secondary)
            .make(),
        // "Trending products".text.xl2.make(),
        ListTile(
            leading: IconButton(
                onPressed: (() {
                  showSearch(context: context, delegate: Mysearch());
                }),
                icon: const Icon(Icons.search)),
            trailing: PopupMenuButton(
              icon: Icon(Icons.filter_alt),
              onSelected: (value) {
                setState(() {
                  if (value == 'Year') {
                    MovieModel.items.sort((a, b) => a.year.compareTo(b.year));
                  } else if (value == 'IMDb') {
                    MovieModel.items.sort((a, b) => a.imdb.compareTo(b.imdb));
                  }
                });
              },
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'IMDb',
                    child: Text('IMDb'),
                  ),
                  PopupMenuItem(
                    value: 'Year',
                    child: Text('Year'),
                  ),
                ];
              },
            ))
      ],
    );
  }
}

class Mysearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = '';
          }),
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: (() {
          return close(context, null);
        }),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final item = query.isEmptyOrNull
        ? MovieModel.items
        : MovieModel.items
            .where((element) => element.title.toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
        itemCount: item.length,
        itemBuilder: ((context, index) => ListTile(
              title: item[index].title.text.make(),
              onTap: () {
                query = item[index].title;
                // Itemss( item: item);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeDetailPage(catalog: item[index])));
              },
              // title: _cart.items[index].title.text.make(),
            )));
  }
}
