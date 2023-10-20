import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/core/store.dart';
import 'package:movies_app/models/favourite.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/utils/routes.dart';
import 'package:movies_app/widgets/home_widgets/movie_header.dart';
import 'package:movies_app/widgets/home_widgets/movie_list.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assests/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    MovieModel.items =
        List.from(decodedData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = (VxState.store as Mystore).favourite;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
      ),
      backgroundColor: context.canvasColor,
      floatingActionButton: VxBuilder(
        builder: (context, store, status) => FloatingActionButton(
                onPressed: () =>
                    Navigator.pushNamed(context, MyRoutes.FavouriteRoute),
                backgroundColor: Vx.indigo500,
                child: const Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.white,
                ))
            .badge(
                color: Vx.red500,
                size: 22,
                count: cart.items.length,
                textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
        mutations: const {AddMutation, RemoveMutation},
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieHeader(),
              if (MovieModel.items.isNotEmpty)
                MovieList(selectedFilter: "None").py16().expand()
              else
                const CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}
