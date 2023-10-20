// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:movies_app/models/favourite.dart';
import 'package:movies_app/models/movie.dart';
import 'package:velocity_x/velocity_x.dart';

class Mystore extends VxStore {
  late MovieModel movie;
  late FavouriteModel favourite;
  Mystore() {
    movie = MovieModel();
    favourite = FavouriteModel();
    favourite.movie = movie;
  }
}
