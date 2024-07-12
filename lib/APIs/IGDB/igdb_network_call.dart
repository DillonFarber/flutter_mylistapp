import 'dart:convert';
import 'dart:developer' as devtools show log;
import 'package:http/http.dart' as http;
import 'package:mylistapp/APIs/IGDB/igdb.dart';
import 'dart:async';

import 'package:mylistapp/APIs/igdb_get_games.dart';

class IgdbCall {
  IgdbCall._();
  static var client = http.Client();
  static const String _baseUrl = 'https://api.igdb.com/v4';
  static const String _tokenUrl = "https://id.twitch.tv/oauth2/token";
  static const String _gamesBody =
      "fields name, cover.*, artworks.*, age_ratings.*, age_ratings.rating, age_ratings.category, age_ratings.content_descriptions.*, screenshots.*;";
  static const String _bodyListGames =
      "fields name, cover.*, first_release_date, artworks.*, screenshots.*, platforms.*, platforms.platform_logo.image_id, "
      "summary, storyline, release_dates.human, release_dates.platform.name, alternative_names.*,"
      "dlcs.*, rating, status, expansions.*, similar_games, themes.name, url, game_modes.name, genres.name,"
      "involved_companies.*, involved_companies.company.name,  videos.name, videos.video_id, websites.*,"
      "keywords.*, parent_game.*, player_perspectives.*, total_rating, game_localizations.*; ";

  static late IGDBBearer? _bearerToken;

  static String unixTime =
      (DateTime.now().millisecondsSinceEpoch / 1000).toString();

  static Future<void> fetchBearer() async {
    final response = await client.post(
      Uri.parse(_tokenUrl),
      body: {
        "client_id": "wdcga06wfwk5r6ioi0el9i89sstg6m",
        "client_secret": "fpsmypfczeipp04idqcv4efhwecqby",
        "grant_type": "client_credentials"
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _bearerToken = IGDBBearer.fromJson(data);
      devtools.log(_bearerToken!.accessToken.toString());
    } else {
      throw Exception('Failed to post data');
    }
  }

  static Future<List<IgdbGetGamesList>?> fetchGamesList(
      String offset, String pageSize, String? whereArgs) async {
    String wArg =
        "where first_release_date <= ${unixTime.substring(0, unixTime.indexOf('.'))} & category = (0, 8, 11) & platforms.name ="
        "(\"PlayStation 5\", \"PlayStation 4\", \"PC (Microsoft Windows)\", \"Xbox One\", \"Xbox Series X|S\") & age_ratings.rating != (12, 17) & version_parent = null;";
    String body = _bodyListGames + wArg;
    devtools.log(unixTime.substring(0, unixTime.indexOf('.')));
    try {
      final response = await client.post(
        Uri.parse("$_baseUrl/games"),
        headers: {
          "Client-ID": "wdcga06wfwk5r6ioi0el9i89sstg6m",
          "Authorization": "Bearer ${_bearerToken!.accessToken}"
        },
        body: "$body offset $offset; limit $pageSize; sort rating desc;",
      );
      if (response.statusCode == 200) {
        final data = igdbGetGamesListFromJson(utf8.decode(response.bodyBytes));
        return data;
      } else {
        devtools.log(
            "Failed due to response code ${response.statusCode.toString()}");
        throw Exception(
            "Failed due to response code ${response.body.toString()}");
      }
    } catch (e) {
      devtools.log(e.toString());
    }
    return null;
  }

  static Future<List<IgdbGetGame>?> fetchGameData(String name) async {
    String wArg =
        "where first_release_date <= 1713551005 & category = (0, 8, 11) & platforms.name = (\"PlayStation 5\", \"PlayStation 4\", \"PC (Microsoft Windows)\", \"Xbox One\", \"Xbox Series X|S\"); sort first_release_date desc;";
    String wArg2 = "where name = \"$name\";";
    try {
      final response = await client.post(
        Uri.parse("$_baseUrl/games"),
        headers: {
          "Client-ID": "wdcga06wfwk5r6ioi0el9i89sstg6m",
          "Authorization": "Bearer ${_bearerToken!.accessToken}"
        },
        body: "$wArg2$_gamesBody; ",
      );
      if (response.statusCode == 200) {
        final data = igdbGetGameFromJson(response.body.toString());
        devtools.log(data.toString());
        return data;
      } else {
        devtools.log("Failed due to response code ${response.body.toString()}");
        throw Exception(
            "Failed due to response code ${response.statusCode.toString()}");
      }
    } catch (e) {
      devtools.log(e.toString());
    }
    return null;
  }
}


// # The IGDB keys and client info
// IGDB_CLIENT="wdcga06wfwk5r6ioi0el9i89sstg6m"
// IGDB_KEY="fpsmypfczeipp04idqcv4efhwecqby"

// # The movie databases keys
// TMDB_READ_ACCESS_KEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNmFlMTNlZGVhNWIyODE3NmE1NjNjNmZmOTAxYWEwOCIsInN1YiI6IjY0ZWE2Y2Q4NTI1OGFlMDEyY2E1OWJlNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.j92EZ7x26muUK8J0C69ohVzTzRmBG-EBZ1PiH-ymc1k"
// TMDB_CLIENT_ID = ""

// GOOGLE_ACCESS_KEY = "AIzaSyBLTs5tHRLwKEwTTb9AcveUFHfucZnCTdY"
