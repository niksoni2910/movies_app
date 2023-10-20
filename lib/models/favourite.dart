import 'package:movies_app/core/store.dart';
import 'package:movies_app/models/movie.dart';
import 'package:velocity_x/velocity_x.dart';

class FavouriteModel {
  // catalog field
  late MovieModel _movie;

  //colletion oF ID's - store id of each element
  final List<String> _itemIds = [];

  //Get catalog
  MovieModel get movie => _movie;

  set movie(MovieModel newMovie) {
    _movie = newMovie;
  }

  //Get items in the cart
  List<Item> get items =>
      _itemIds.map((title) => _movie.getByName(title)).toList();

  //Get totalprice
  // num get totalPrice =>
  //     items.fold(0, (total, current) => total + current.price);
}

class AddMutation extends VxMutation<Mystore> {
  final Item item;

  AddMutation(this.item);
  @override
  perform() {
    store?.favourite._itemIds.add(item.title);
  }
}

class RemoveMutation extends VxMutation<Mystore> {
  final Item item;

  RemoveMutation(this.item);
  @override
  perform() {
    store?.favourite._itemIds.remove(item.title);
  }
}
