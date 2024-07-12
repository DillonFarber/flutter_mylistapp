// To parse this JSON data, do
//
//     final igdbGetGame = igdbGetGameFromJson(jsonString);

import 'dart:convert';

List<IgdbGetGame> igdbGetGameFromJson(String str) => List<IgdbGetGame>.from(
    json.decode(str).map((x) => IgdbGetGame.fromJson(x)));

String igdbGetGameToJson(List<IgdbGetGame> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IgdbGetGame {
  int id;
  List<AgeRating>? ageRatings;
  Cover? cover;
  String name;
  List<Cover>? screenshots;
  List<Cover>? artworks;

  IgdbGetGame({
    required this.id,
    this.ageRatings,
    this.cover,
    required this.name,
    this.screenshots,
    this.artworks,
  });

  factory IgdbGetGame.fromJson(Map<String, dynamic> json) => IgdbGetGame(
        id: json["id"],
        ageRatings: json["age_ratings"] == null
            ? []
            : List<AgeRating>.from(
                json["age_ratings"]!.map((x) => AgeRating.fromJson(x))),
        cover: json["cover"] == null ? null : Cover.fromJson(json["cover"]),
        name: json["name"],
        screenshots: json["screenshots"] == null
            ? []
            : List<Cover>.from(
                json["screenshots"]!.map((x) => Cover.fromJson(x))),
        artworks: json["artworks"] == null
            ? []
            : List<Cover>.from(json["artworks"]!.map((x) => Cover.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "age_ratings": ageRatings == null
            ? []
            : List<dynamic>.from(ageRatings!.map((x) => x.toJson())),
        "cover": cover?.toJson(),
        "name": name,
        "screenshots": screenshots == null
            ? []
            : List<dynamic>.from(screenshots!.map((x) => x.toJson())),
        "artworks": artworks == null
            ? []
            : List<dynamic>.from(artworks!.map((x) => x.toJson())),
      };
}

class AgeRating {
  int id;
  int? category;
  int? rating;
  String? checksum;
  List<ContentDescription>? contentDescriptions;

  AgeRating({
    required this.id,
    this.category,
    this.rating,
    this.checksum,
    this.contentDescriptions,
  });

  factory AgeRating.fromJson(Map<String, dynamic> json) => AgeRating(
        id: json["id"],
        category: json["category"],
        rating: json["rating"],
        checksum: json["checksum"],
        contentDescriptions: json["content_descriptions"] == null
            ? []
            : List<ContentDescription>.from(json["content_descriptions"]!
                .map((x) => ContentDescription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "rating": rating,
        "checksum": checksum,
        "content_descriptions": contentDescriptions == null
            ? []
            : List<dynamic>.from(contentDescriptions!.map((x) => x.toJson())),
      };
}

class ContentDescription {
  int id;
  int? category;
  String? description;
  String? checksum;

  ContentDescription({
    required this.id,
    this.category,
    this.description,
    this.checksum,
  });

  factory ContentDescription.fromJson(Map<String, dynamic> json) =>
      ContentDescription(
        id: json["id"],
        category: json["category"],
        description: json["description"],
        checksum: json["checksum"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "description": description,
        "checksum": checksum,
      };
}

class Cover {
  int id;
  bool? alphaChannel;
  bool? animated;
  int? game;
  int? height;
  String? imageId;
  String? url;
  int? width;
  String? checksum;

  Cover({
    required this.id,
    this.alphaChannel,
    this.animated,
    this.game,
    this.height,
    this.imageId,
    this.url,
    this.width,
    this.checksum,
  });

  factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        id: json["id"],
        alphaChannel: json["alpha_channel"],
        animated: json["animated"],
        game: json["game"],
        height: json["height"],
        imageId: json["image_id"],
        url: json["url"],
        width: json["width"],
        checksum: json["checksum"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alpha_channel": alphaChannel,
        "animated": animated,
        "game": game,
        "height": height,
        "image_id": imageId,
        "url": url,
        "width": width,
        "checksum": checksum,
      };
}
