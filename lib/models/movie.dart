// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MovieModel {
  static List<Item> items = [];

  //get element by id
  Item getByName(String title) =>
      items.firstWhere((element) => element.title == title, orElse: null);

  //get item by position
  Item getByPosition(int pos) => items[pos];
}

class Item {
  final String title;
  final String description;
  final String year;
  final num imdb;
  final String image;
  final List<dynamic> ratings;

  Item(
      {required this.title,
      required this.description,
      required this.year,
      required this.imdb,
      required this.image,
      required this.ratings});

  Item copyWith({
    String? title,
    String? description,
    String? year,
    num? imdb,
    String? image,
    List<num>? ratings,
  }) {
    return Item(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      ratings: ratings ?? this.ratings,
      imdb: imdb ?? this.imdb,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'storyline': description,
      'poster': image,
      'year': year,
      'imdbRating': imdb,
      'ratings': ratings,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        title: map['title'] as String,
        description: map['storyline'] as String,
        image: map['poster'] as String,
        year: map['year'] as String,
        imdb: map['imdbRating'] as num,
        ratings: map['ratings'] as List<dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(title: $title, description: $description, image: $image, year: $year , imdb : $imdb)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.image == image &&
        other.imdb == imdb &&
        other.year == year &&
        other.ratings == ratings;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        ratings.hashCode ^
        year.hashCode ^
        imdb.hashCode;
  }
}
