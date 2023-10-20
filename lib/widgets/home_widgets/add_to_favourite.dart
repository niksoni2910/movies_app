import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/store.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/favourite.dart';
import '../../models/movie.dart';

class AddtoCart extends StatelessWidget {
  final Item catalog;
  const AddtoCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final FavouriteModel _cart = (VxState.store as Mystore).favourite;
    bool isInCart = _cart.items.contains(catalog);
    return ElevatedButton(
        onPressed: () {
          if (!isInCart) {
            AddMutation(catalog);
            // setState(() {});
          }
          if (isInCart) {
            RemoveMutation(catalog);
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Vx.indigo500),
            shape: MaterialStateProperty.all(
              const StadiumBorder(),
            )),
        child: isInCart ? const Text("Added") : const Text("Favourites"));
  }
}
