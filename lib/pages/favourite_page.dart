import 'package:flutter/material.dart';
import 'package:movies_app/models/favourite.dart';
import 'package:movies_app/pages/home_detail_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Favourites".text.make(),
      ),
      body: Column(
        children: [
          _FavouriteList().py32().expand(),
          const Divider(),
          _BotButton(),
        ],
      ),
    );
  }
}

class _BotButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final FavouriteModel _cart = (VxState.store as Mystore).favourite;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
                  onPressed: (() {
                    Navigator.pop(context);
                  }),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Vx.indigo500)),
                  child: "Go to Home Page".text.white.make())
              .w64(context)
        ],
      ),
    );
  }
}

class _FavouriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final FavouriteModel _cart = (VxState.store as Mystore).favourite;
    return _cart.items.isEmpty
        ? "Nothing to show".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.done),
              trailing: IconButton(
                  onPressed: () => RemoveMutation(_cart.items[index]),
                  icon: const Icon(Icons.remove_circle_outline)),
              title: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeDetailPage(
                                catalog: _cart.items[index],
                              )));
                },
                child: _cart.items[index].title.text.make(),
              ),
            ),
          );
  }
}
