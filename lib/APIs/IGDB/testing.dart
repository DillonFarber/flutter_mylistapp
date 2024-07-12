// To parse this JSON data, do
//
//     final igdbGetGamesList1 = igdbGetGamesList1FromJson(jsonString);

import 'dart:convert';

List<IgdbGetGamesList1> igdbGetGamesList1FromJson(String str) => List<IgdbGetGamesList1>.from(json.decode(str).map((x) => IgdbGetGamesList1.fromJson(x)));

String igdbGetGamesList1ToJson(List<IgdbGetGamesList1> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IgdbGetGamesList1 {
    int? id;
    List<Cover>? artworks;
    Cover? cover;
    int? firstReleaseDate;
    String? name;
    List<Platform>? platforms;
    List<ReleaseDate>? releaseDates;
    List<Cover>? screenshots;
    List<int>? similarGames;
    List<GameMode>? themes;
    String? url;
    List<GameMode>? genres;
    List<GameMode>? gameModes;
    List<InvolvedCompany>? involvedCompanies;
    ParentGame? parentGame;
    String? summary;
    List<Video>? videos;
    List<Website>? websites;
    List<AlternativeName>? alternativeNames;
    List<Keyword>? keywords;
    List<Keyword>? playerPerspectives;
    String? storyline;
    double? totalRating;
    List<GameLocalization>? gameLocalizations;
    List<Dlc>? dlcs;
    List<MultiplayerMode>? multiplayerModes;
    double? rating;
    int? status;

    IgdbGetGamesList1({
        this.id,
        this.artworks,
        this.cover,
        this.firstReleaseDate,
        this.name,
        this.platforms,
        this.releaseDates,
        this.screenshots,
        this.similarGames,
        this.themes,
        this.url,
        this.genres,
        this.gameModes,
        this.involvedCompanies,
        this.parentGame,
        this.summary,
        this.videos,
        this.websites,
        this.alternativeNames,
        this.keywords,
        this.playerPerspectives,
        this.storyline,
        this.totalRating,
        this.gameLocalizations,
        this.dlcs,
        this.multiplayerModes,
        this.rating,
        this.status,
    });

    factory IgdbGetGamesList1.fromJson(Map<String, dynamic> json) => IgdbGetGamesList1(
        id: json["id"],
        artworks: json["artworks"] == null ? [] : List<Cover>.from(json["artworks"]!.map((x) => Cover.fromJson(x))),
        cover: json["cover"] == null ? null : Cover.fromJson(json["cover"]),
        firstReleaseDate: json["first_release_date"],
        name: json["name"],
        platforms: json["platforms"] == null ? [] : List<Platform>.from(json["platforms"]!.map((x) => Platform.fromJson(x))),
        releaseDates: json["release_dates"] == null ? [] : List<ReleaseDate>.from(json["release_dates"]!.map((x) => ReleaseDate.fromJson(x))),
        screenshots: json["screenshots"] == null ? [] : List<Cover>.from(json["screenshots"]!.map((x) => Cover.fromJson(x))),
        similarGames: json["similar_games"] == null ? [] : List<int>.from(json["similar_games"]!.map((x) => x)),
        themes: json["themes"] == null ? [] : List<GameMode>.from(json["themes"]!.map((x) => GameMode.fromJson(x))),
        url: json["url"],
        genres: json["genres"] == null ? [] : List<GameMode>.from(json["genres"]!.map((x) => GameMode.fromJson(x))),
        gameModes: json["game_modes"] == null ? [] : List<GameMode>.from(json["game_modes"]!.map((x) => GameMode.fromJson(x))),
        involvedCompanies: json["involved_companies"] == null ? [] : List<InvolvedCompany>.from(json["involved_companies"]!.map((x) => InvolvedCompany.fromJson(x))),
        parentGame: json["parent_game"] == null ? null : ParentGame.fromJson(json["parent_game"]),
        summary: json["summary"],
        videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
        websites: json["websites"] == null ? [] : List<Website>.from(json["websites"]!.map((x) => Website.fromJson(x))),
        alternativeNames: json["alternative_names"] == null ? [] : List<AlternativeName>.from(json["alternative_names"]!.map((x) => AlternativeName.fromJson(x))),
        keywords: json["keywords"] == null ? [] : List<Keyword>.from(json["keywords"]!.map((x) => Keyword.fromJson(x))),
        playerPerspectives: json["player_perspectives"] == null ? [] : List<Keyword>.from(json["player_perspectives"]!.map((x) => Keyword.fromJson(x))),
        storyline: json["storyline"],
        totalRating: json["total_rating"]?.toDouble(),
        gameLocalizations: json["game_localizations"] == null ? [] : List<GameLocalization>.from(json["game_localizations"]!.map((x) => GameLocalization.fromJson(x))),
        dlcs: json["dlcs"] == null ? [] : List<Dlc>.from(json["dlcs"]!.map((x) => Dlc.fromJson(x))),
        multiplayerModes: json["multiplayer_modes"] == null ? [] : List<MultiplayerMode>.from(json["multiplayer_modes"]!.map((x) => MultiplayerMode.fromJson(x))),
        rating: json["rating"]?.toDouble(),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "artworks": artworks == null ? [] : List<dynamic>.from(artworks!.map((x) => x.toJson())),
        "cover": cover?.toJson(),
        "first_release_date": firstReleaseDate,
        "name": name,
        "platforms": platforms == null ? [] : List<dynamic>.from(platforms!.map((x) => x.toJson())),
        "release_dates": releaseDates == null ? [] : List<dynamic>.from(releaseDates!.map((x) => x.toJson())),
        "screenshots": screenshots == null ? [] : List<dynamic>.from(screenshots!.map((x) => x.toJson())),
        "similar_games": similarGames == null ? [] : List<dynamic>.from(similarGames!.map((x) => x)),
        "themes": themes == null ? [] : List<dynamic>.from(themes!.map((x) => x.toJson())),
        "url": url,
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "game_modes": gameModes == null ? [] : List<dynamic>.from(gameModes!.map((x) => x.toJson())),
        "involved_companies": involvedCompanies == null ? [] : List<dynamic>.from(involvedCompanies!.map((x) => x.toJson())),
        "parent_game": parentGame?.toJson(),
        "summary": summary,
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "websites": websites == null ? [] : List<dynamic>.from(websites!.map((x) => x.toJson())),
        "alternative_names": alternativeNames == null ? [] : List<dynamic>.from(alternativeNames!.map((x) => x.toJson())),
        "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x.toJson())),
        "player_perspectives": playerPerspectives == null ? [] : List<dynamic>.from(playerPerspectives!.map((x) => x.toJson())),
        "storyline": storyline,
        "total_rating": totalRating,
        "game_localizations": gameLocalizations == null ? [] : List<dynamic>.from(gameLocalizations!.map((x) => x.toJson())),
        "dlcs": dlcs == null ? [] : List<dynamic>.from(dlcs!.map((x) => x.toJson())),
        "multiplayer_modes": multiplayerModes == null ? [] : List<dynamic>.from(multiplayerModes!.map((x) => x.toJson())),
        "rating": rating,
        "status": status,
    };
}

class AlternativeName {
    int? id;
    String? comment;
    int? game;
    String? name;
    String? checksum;

    AlternativeName({
        this.id,
        this.comment,
        this.game,
        this.name,
        this.checksum,
    });

    factory AlternativeName.fromJson(Map<String, dynamic> json) => AlternativeName(
        id: json["id"],
        comment: json["comment"],
        game: json["game"],
        name: json["name"],
        checksum: json["checksum"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "game": game,
        "name": name,
        "checksum": checksum,
    };
}

class Cover {
    int? id;
    String? imageId;

    Cover({
        this.id,
        this.imageId,
    });

    factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        id: json["id"],
        imageId: json["image_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_id": imageId,
    };
}

class Dlc {
    int? id;
    List<int>? ageRatings;
    List<int>? artworks;
    int? category;
    int? cover;
    int? createdAt;
    List<int>? externalGames;
    int? firstReleaseDate;
    List<int>? gameModes;
    List<int>? genres;
    List<int>? involvedCompanies;
    String? name;
    int? parentGame;
    List<int>? platforms;
    List<int>? playerPerspectives;
    List<int>? releaseDates;
    List<int>? screenshots;
    List<int>? similarGames;
    String? slug;
    String? summary;
    List<int>? tags;
    List<int>? themes;
    int? updatedAt;
    String? url;
    List<int>? websites;
    String? checksum;
    List<int>? languageSupports;

    Dlc({
        this.id,
        this.ageRatings,
        this.artworks,
        this.category,
        this.cover,
        this.createdAt,
        this.externalGames,
        this.firstReleaseDate,
        this.gameModes,
        this.genres,
        this.involvedCompanies,
        this.name,
        this.parentGame,
        this.platforms,
        this.playerPerspectives,
        this.releaseDates,
        this.screenshots,
        this.similarGames,
        this.slug,
        this.summary,
        this.tags,
        this.themes,
        this.updatedAt,
        this.url,
        this.websites,
        this.checksum,
        this.languageSupports,
    });

    factory Dlc.fromJson(Map<String, dynamic> json) => Dlc(
        id: json["id"],
        ageRatings: json["age_ratings"] == null ? [] : List<int>.from(json["age_ratings"]!.map((x) => x)),
        artworks: json["artworks"] == null ? [] : List<int>.from(json["artworks"]!.map((x) => x)),
        category: json["category"],
        cover: json["cover"],
        createdAt: json["created_at"],
        externalGames: json["external_games"] == null ? [] : List<int>.from(json["external_games"]!.map((x) => x)),
        firstReleaseDate: json["first_release_date"],
        gameModes: json["game_modes"] == null ? [] : List<int>.from(json["game_modes"]!.map((x) => x)),
        genres: json["genres"] == null ? [] : List<int>.from(json["genres"]!.map((x) => x)),
        involvedCompanies: json["involved_companies"] == null ? [] : List<int>.from(json["involved_companies"]!.map((x) => x)),
        name: json["name"],
        parentGame: json["parent_game"],
        platforms: json["platforms"] == null ? [] : List<int>.from(json["platforms"]!.map((x) => x)),
        playerPerspectives: json["player_perspectives"] == null ? [] : List<int>.from(json["player_perspectives"]!.map((x) => x)),
        releaseDates: json["release_dates"] == null ? [] : List<int>.from(json["release_dates"]!.map((x) => x)),
        screenshots: json["screenshots"] == null ? [] : List<int>.from(json["screenshots"]!.map((x) => x)),
        similarGames: json["similar_games"] == null ? [] : List<int>.from(json["similar_games"]!.map((x) => x)),
        slug: json["slug"],
        summary: json["summary"],
        tags: json["tags"] == null ? [] : List<int>.from(json["tags"]!.map((x) => x)),
        themes: json["themes"] == null ? [] : List<int>.from(json["themes"]!.map((x) => x)),
        updatedAt: json["updated_at"],
        url: json["url"],
        websites: json["websites"] == null ? [] : List<int>.from(json["websites"]!.map((x) => x)),
        checksum: json["checksum"],
        languageSupports: json["language_supports"] == null ? [] : List<int>.from(json["language_supports"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "age_ratings": ageRatings == null ? [] : List<dynamic>.from(ageRatings!.map((x) => x)),
        "artworks": artworks == null ? [] : List<dynamic>.from(artworks!.map((x) => x)),
        "category": category,
        "cover": cover,
        "created_at": createdAt,
        "external_games": externalGames == null ? [] : List<dynamic>.from(externalGames!.map((x) => x)),
        "first_release_date": firstReleaseDate,
        "game_modes": gameModes == null ? [] : List<dynamic>.from(gameModes!.map((x) => x)),
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "involved_companies": involvedCompanies == null ? [] : List<dynamic>.from(involvedCompanies!.map((x) => x)),
        "name": name,
        "parent_game": parentGame,
        "platforms": platforms == null ? [] : List<dynamic>.from(platforms!.map((x) => x)),
        "player_perspectives": playerPerspectives == null ? [] : List<dynamic>.from(playerPerspectives!.map((x) => x)),
        "release_dates": releaseDates == null ? [] : List<dynamic>.from(releaseDates!.map((x) => x)),
        "screenshots": screenshots == null ? [] : List<dynamic>.from(screenshots!.map((x) => x)),
        "similar_games": similarGames == null ? [] : List<dynamic>.from(similarGames!.map((x) => x)),
        "slug": slug,
        "summary": summary,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "themes": themes == null ? [] : List<dynamic>.from(themes!.map((x) => x)),
        "updated_at": updatedAt,
        "url": url,
        "websites": websites == null ? [] : List<dynamic>.from(websites!.map((x) => x)),
        "checksum": checksum,
        "language_supports": languageSupports == null ? [] : List<dynamic>.from(languageSupports!.map((x) => x)),
    };
}

class GameLocalization {
    int? id;
    String? name;
    int? game;
    int? region;
    int? createdAt;
    int? updatedAt;
    String? checksum;
    int? cover;

    GameLocalization({
        this.id,
        this.name,
        this.game,
        this.region,
        this.createdAt,
        this.updatedAt,
        this.checksum,
        this.cover,
    });

    factory GameLocalization.fromJson(Map<String, dynamic> json) => GameLocalization(
        id: json["id"],
        name: json["name"],
        game: json["game"],
        region: json["region"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        checksum: json["checksum"],
        cover: json["cover"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "game": game,
        "region": region,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "checksum": checksum,
        "cover": cover,
    };
}

class GameMode {
    int? id;
    String? name;

    GameMode({
        this.id,
        this.name,
    });

    factory GameMode.fromJson(Map<String, dynamic> json) => GameMode(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class InvolvedCompany {
    int? id;
    GameMode? company;
    int? createdAt;
    bool? developer;
    int? game;
    bool? porting;
    bool? publisher;
    bool? supporting;
    int? updatedAt;
    String? checksum;

    InvolvedCompany({
        this.id,
        this.company,
        this.createdAt,
        this.developer,
        this.game,
        this.porting,
        this.publisher,
        this.supporting,
        this.updatedAt,
        this.checksum,
    });

    factory InvolvedCompany.fromJson(Map<String, dynamic> json) => InvolvedCompany(
        id: json["id"],
        company: json["company"] == null ? null : GameMode.fromJson(json["company"]),
        createdAt: json["created_at"],
        developer: json["developer"],
        game: json["game"],
        porting: json["porting"],
        publisher: json["publisher"],
        supporting: json["supporting"],
        updatedAt: json["updated_at"],
        checksum: json["checksum"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company": company?.toJson(),
        "created_at": createdAt,
        "developer": developer,
        "game": game,
        "porting": porting,
        "publisher": publisher,
        "supporting": supporting,
        "updated_at": updatedAt,
        "checksum": checksum,
    };
}

class Keyword {
    int? id;
    int? createdAt;
    String? name;
    String? slug;
    int? updatedAt;
    String? url;
    String? checksum;

    Keyword({
        this.id,
        this.createdAt,
        this.name,
        this.slug,
        this.updatedAt,
        this.url,
        this.checksum,
    });

    factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
        id: json["id"],
        createdAt: json["created_at"],
        name: json["name"],
        slug: json["slug"],
        updatedAt: json["updated_at"],
        url: json["url"],
        checksum: json["checksum"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "name": name,
        "slug": slug,
        "updated_at": updatedAt,
        "url": url,
        "checksum": checksum,
    };
}

class MultiplayerMode {
    int? id;
    bool? campaigncoop;
    bool? dropin;
    int? game;
    bool? lancoop;
    bool? offlinecoop;
    int? offlinecoopmax;
    int? offlinemax;
    bool? onlinecoop;
    int? onlinecoopmax;
    GameMode? platform;
    bool? splitscreen;
    String? checksum;
    int? onlinemax;

    MultiplayerMode({
        this.id,
        this.campaigncoop,
        this.dropin,
        this.game,
        this.lancoop,
        this.offlinecoop,
        this.offlinecoopmax,
        this.offlinemax,
        this.onlinecoop,
        this.onlinecoopmax,
        this.platform,
        this.splitscreen,
        this.checksum,
        this.onlinemax,
    });

    factory MultiplayerMode.fromJson(Map<String, dynamic> json) => MultiplayerMode(
        id: json["id"],
        campaigncoop: json["campaigncoop"],
        dropin: json["dropin"],
        game: json["game"],
        lancoop: json["lancoop"],
        offlinecoop: json["offlinecoop"],
        offlinecoopmax: json["offlinecoopmax"],
        offlinemax: json["offlinemax"],
        onlinecoop: json["onlinecoop"],
        onlinecoopmax: json["onlinecoopmax"],
        platform: json["platform"] == null ? null : GameMode.fromJson(json["platform"]),
        splitscreen: json["splitscreen"],
        checksum: json["checksum"],
        onlinemax: json["onlinemax"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "campaigncoop": campaigncoop,
        "dropin": dropin,
        "game": game,
        "lancoop": lancoop,
        "offlinecoop": offlinecoop,
        "offlinecoopmax": offlinecoopmax,
        "offlinemax": offlinemax,
        "onlinecoop": onlinecoop,
        "onlinecoopmax": onlinecoopmax,
        "platform": platform?.toJson(),
        "splitscreen": splitscreen,
        "checksum": checksum,
        "onlinemax": onlinemax,
    };
}

class ParentGame {
    int? id;
    List<int>? alternativeNames;
    int? category;
    int? collection;
    int? cover;
    int? createdAt;
    List<int>? externalGames;
    int? firstReleaseDate;
    List<int>? genres;
    List<int>? involvedCompanies;
    List<int>? keywords;
    String? name;
    List<int>? platforms;
    List<int>? playerPerspectives;
    List<int>? releaseDates;
    List<int>? screenshots;
    List<int>? similarGames;
    String? slug;
    String? summary;
    List<int>? tags;
    List<int>? themes;
    int? updatedAt;
    String? url;
    List<int>? videos;
    List<int>? websites;
    String? checksum;
    List<int>? ports;
    List<int>? gameLocalizations;
    List<int>? collections;
    List<int>? ageRatings;
    double? aggregatedRating;
    int? aggregatedRatingCount;
    int? franchise;
    List<int>? franchises;
    List<int>? gameModes;
    double? totalRating;
    int? totalRatingCount;
    List<int>? remakes;
    List<int>? languageSupports;
    List<int>? artworks;
    int? hypes;
    List<int>? multiplayerModes;
    double? rating;
    int? ratingCount;
    List<int>? bundles;
    String? storyline;
    int? parentGame;
    List<int>? expandedGames;

    ParentGame({
        this.id,
        this.alternativeNames,
        this.category,
        this.collection,
        this.cover,
        this.createdAt,
        this.externalGames,
        this.firstReleaseDate,
        this.genres,
        this.involvedCompanies,
        this.keywords,
        this.name,
        this.platforms,
        this.playerPerspectives,
        this.releaseDates,
        this.screenshots,
        this.similarGames,
        this.slug,
        this.summary,
        this.tags,
        this.themes,
        this.updatedAt,
        this.url,
        this.videos,
        this.websites,
        this.checksum,
        this.ports,
        this.gameLocalizations,
        this.collections,
        this.ageRatings,
        this.aggregatedRating,
        this.aggregatedRatingCount,
        this.franchise,
        this.franchises,
        this.gameModes,
        this.totalRating,
        this.totalRatingCount,
        this.remakes,
        this.languageSupports,
        this.artworks,
        this.hypes,
        this.multiplayerModes,
        this.rating,
        this.ratingCount,
        this.bundles,
        this.storyline,
        this.parentGame,
        this.expandedGames,
    });

    factory ParentGame.fromJson(Map<String, dynamic> json) => ParentGame(
        id: json["id"],
        alternativeNames: json["alternative_names"] == null ? [] : List<int>.from(json["alternative_names"]!.map((x) => x)),
        category: json["category"],
        collection: json["collection"],
        cover: json["cover"],
        createdAt: json["created_at"],
        externalGames: json["external_games"] == null ? [] : List<int>.from(json["external_games"]!.map((x) => x)),
        firstReleaseDate: json["first_release_date"],
        genres: json["genres"] == null ? [] : List<int>.from(json["genres"]!.map((x) => x)),
        involvedCompanies: json["involved_companies"] == null ? [] : List<int>.from(json["involved_companies"]!.map((x) => x)),
        keywords: json["keywords"] == null ? [] : List<int>.from(json["keywords"]!.map((x) => x)),
        name: json["name"],
        platforms: json["platforms"] == null ? [] : List<int>.from(json["platforms"]!.map((x) => x)),
        playerPerspectives: json["player_perspectives"] == null ? [] : List<int>.from(json["player_perspectives"]!.map((x) => x)),
        releaseDates: json["release_dates"] == null ? [] : List<int>.from(json["release_dates"]!.map((x) => x)),
        screenshots: json["screenshots"] == null ? [] : List<int>.from(json["screenshots"]!.map((x) => x)),
        similarGames: json["similar_games"] == null ? [] : List<int>.from(json["similar_games"]!.map((x) => x)),
        slug: json["slug"],
        summary: json["summary"],
        tags: json["tags"] == null ? [] : List<int>.from(json["tags"]!.map((x) => x)),
        themes: json["themes"] == null ? [] : List<int>.from(json["themes"]!.map((x) => x)),
        updatedAt: json["updated_at"],
        url: json["url"],
        videos: json["videos"] == null ? [] : List<int>.from(json["videos"]!.map((x) => x)),
        websites: json["websites"] == null ? [] : List<int>.from(json["websites"]!.map((x) => x)),
        checksum: json["checksum"],
        ports: json["ports"] == null ? [] : List<int>.from(json["ports"]!.map((x) => x)),
        gameLocalizations: json["game_localizations"] == null ? [] : List<int>.from(json["game_localizations"]!.map((x) => x)),
        collections: json["collections"] == null ? [] : List<int>.from(json["collections"]!.map((x) => x)),
        ageRatings: json["age_ratings"] == null ? [] : List<int>.from(json["age_ratings"]!.map((x) => x)),
        aggregatedRating: json["aggregated_rating"]?.toDouble(),
        aggregatedRatingCount: json["aggregated_rating_count"],
        franchise: json["franchise"],
        franchises: json["franchises"] == null ? [] : List<int>.from(json["franchises"]!.map((x) => x)),
        gameModes: json["game_modes"] == null ? [] : List<int>.from(json["game_modes"]!.map((x) => x)),
        totalRating: json["total_rating"]?.toDouble(),
        totalRatingCount: json["total_rating_count"],
        remakes: json["remakes"] == null ? [] : List<int>.from(json["remakes"]!.map((x) => x)),
        languageSupports: json["language_supports"] == null ? [] : List<int>.from(json["language_supports"]!.map((x) => x)),
        artworks: json["artworks"] == null ? [] : List<int>.from(json["artworks"]!.map((x) => x)),
        hypes: json["hypes"],
        multiplayerModes: json["multiplayer_modes"] == null ? [] : List<int>.from(json["multiplayer_modes"]!.map((x) => x)),
        rating: json["rating"]?.toDouble(),
        ratingCount: json["rating_count"],
        bundles: json["bundles"] == null ? [] : List<int>.from(json["bundles"]!.map((x) => x)),
        storyline: json["storyline"],
        parentGame: json["parent_game"],
        expandedGames: json["expanded_games"] == null ? [] : List<int>.from(json["expanded_games"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "alternative_names": alternativeNames == null ? [] : List<dynamic>.from(alternativeNames!.map((x) => x)),
        "category": category,
        "collection": collection,
        "cover": cover,
        "created_at": createdAt,
        "external_games": externalGames == null ? [] : List<dynamic>.from(externalGames!.map((x) => x)),
        "first_release_date": firstReleaseDate,
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "involved_companies": involvedCompanies == null ? [] : List<dynamic>.from(involvedCompanies!.map((x) => x)),
        "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x)),
        "name": name,
        "platforms": platforms == null ? [] : List<dynamic>.from(platforms!.map((x) => x)),
        "player_perspectives": playerPerspectives == null ? [] : List<dynamic>.from(playerPerspectives!.map((x) => x)),
        "release_dates": releaseDates == null ? [] : List<dynamic>.from(releaseDates!.map((x) => x)),
        "screenshots": screenshots == null ? [] : List<dynamic>.from(screenshots!.map((x) => x)),
        "similar_games": similarGames == null ? [] : List<dynamic>.from(similarGames!.map((x) => x)),
        "slug": slug,
        "summary": summary,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "themes": themes == null ? [] : List<dynamic>.from(themes!.map((x) => x)),
        "updated_at": updatedAt,
        "url": url,
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
        "websites": websites == null ? [] : List<dynamic>.from(websites!.map((x) => x)),
        "checksum": checksum,
        "ports": ports == null ? [] : List<dynamic>.from(ports!.map((x) => x)),
        "game_localizations": gameLocalizations == null ? [] : List<dynamic>.from(gameLocalizations!.map((x) => x)),
        "collections": collections == null ? [] : List<dynamic>.from(collections!.map((x) => x)),
        "age_ratings": ageRatings == null ? [] : List<dynamic>.from(ageRatings!.map((x) => x)),
        "aggregated_rating": aggregatedRating,
        "aggregated_rating_count": aggregatedRatingCount,
        "franchise": franchise,
        "franchises": franchises == null ? [] : List<dynamic>.from(franchises!.map((x) => x)),
        "game_modes": gameModes == null ? [] : List<dynamic>.from(gameModes!.map((x) => x)),
        "total_rating": totalRating,
        "total_rating_count": totalRatingCount,
        "remakes": remakes == null ? [] : List<dynamic>.from(remakes!.map((x) => x)),
        "language_supports": languageSupports == null ? [] : List<dynamic>.from(languageSupports!.map((x) => x)),
        "artworks": artworks == null ? [] : List<dynamic>.from(artworks!.map((x) => x)),
        "hypes": hypes,
        "multiplayer_modes": multiplayerModes == null ? [] : List<dynamic>.from(multiplayerModes!.map((x) => x)),
        "rating": rating,
        "rating_count": ratingCount,
        "bundles": bundles == null ? [] : List<dynamic>.from(bundles!.map((x) => x)),
        "storyline": storyline,
        "parent_game": parentGame,
        "expanded_games": expandedGames == null ? [] : List<dynamic>.from(expandedGames!.map((x) => x)),
    };
}

class Platform {
    int? id;
    Abbreviation? abbreviation;
    Name? name;
    Cover? platformLogo;

    Platform({
        this.id,
        this.abbreviation,
        this.name,
        this.platformLogo,
    });

    factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        id: json["id"],
        abbreviation: abbreviationValues.map[json["abbreviation"]]!,
        name: nameValues.map[json["name"]]!,
        platformLogo: json["platform_logo"] == null ? null : Cover.fromJson(json["platform_logo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "abbreviation": abbreviationValues.reverse[abbreviation],
        "name": nameValues.reverse[name],
        "platform_logo": platformLogo?.toJson(),
    };
}

enum Abbreviation {
    ANDROID,
    I_OS,
    LINUX,
    MAC,
    PC,
    PS4,
    PS5,
    SERIES_X_S,
    SWITCH,
    XONE
}

final abbreviationValues = EnumValues({
    "Android": Abbreviation.ANDROID,
    "iOS": Abbreviation.I_OS,
    "Linux": Abbreviation.LINUX,
    "Mac": Abbreviation.MAC,
    "PC": Abbreviation.PC,
    "PS4": Abbreviation.PS4,
    "PS5": Abbreviation.PS5,
    "Series X|S": Abbreviation.SERIES_X_S,
    "Switch": Abbreviation.SWITCH,
    "XONE": Abbreviation.XONE
});

enum Name {
    ANDROID,
    I_OS,
    LINUX,
    MAC,
    NINTENDO_SWITCH,
    PC_MICROSOFT_WINDOWS,
    PLAY_STATION_4,
    PLAY_STATION_5,
    XBOX_ONE,
    XBOX_SERIES_X_S
}

final nameValues = EnumValues({
    "Android": Name.ANDROID,
    "iOS": Name.I_OS,
    "Linux": Name.LINUX,
    "Mac": Name.MAC,
    "Nintendo Switch": Name.NINTENDO_SWITCH,
    "PC (Microsoft Windows)": Name.PC_MICROSOFT_WINDOWS,
    "PlayStation 4": Name.PLAY_STATION_4,
    "PlayStation 5": Name.PLAY_STATION_5,
    "Xbox One": Name.XBOX_ONE,
    "Xbox Series X|S": Name.XBOX_SERIES_X_S
});

class ReleaseDate {
    int? id;
    String? human;
    GameMode? platform;

    ReleaseDate({
        this.id,
        this.human,
        this.platform,
    });

    factory ReleaseDate.fromJson(Map<String, dynamic> json) => ReleaseDate(
        id: json["id"],
        human: json["human"],
        platform: json["platform"] == null ? null : GameMode.fromJson(json["platform"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "human": human,
        "platform": platform?.toJson(),
    };
}

class Video {
    int? id;
    String? name;
    String? videoId;

    Video({
        this.id,
        this.name,
        this.videoId,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        name: json["name"],
        videoId: json["video_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "video_id": videoId,
    };
}

class Website {
    int? id;
    String? url;

    Website({
        this.id,
        this.url,
    });

    factory Website.fromJson(Map<String, dynamic> json) => Website(
        id: json["id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
