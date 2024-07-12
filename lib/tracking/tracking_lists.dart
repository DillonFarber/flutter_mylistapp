import 'dart:convert';
import 'dart:io';
import 'package:mylistapp/APIs/IGDB/igdb.dart';
import 'dart:developer' as devtools show log;

abstract class Tracking {
  void addList(String listName, dynamic item);
  void deleteList(String listName);
  void addToList(String listName, dynamic item);
  void deleteFromList(String listName, dynamic item);
  void saveToFile();
  void getFromFile();
  void currentItem(dynamic item);
  int lengthOfList();
  List<String> getListNames();
  dynamic getList(String listName);
  dynamic findItem(String listName, dynamic item);
  Map<String, bool> listsThatHaveItem(dynamic item);
}

class TrackingGames extends Tracking {
  TrackingGames._();
  static final TrackingGames _instance = TrackingGames._();

  static TrackingGames get instance => _instance;

  IgdbGetGamesList? currentGame;

  final Map<String, List<IgdbGetGamesList>> _gamesListMap = {"Favorites": []};

  @override
  void addList(String listName, dynamic item) {
    if (item != null) {
      if (!_gamesListMap.containsKey(listName)) {
        _gamesListMap.addAll({
          listName: [item as IgdbGetGamesList]
        });
      } else {
        _gamesListMap[listName]!.add(item as IgdbGetGamesList);
      }
    } else {
      _gamesListMap.addAll({listName: []});
    }
  }

  @override
  void addToList(String listName, dynamic item) {
    if (!_gamesListMap[listName]!.contains(item as IgdbGetGamesList)) {
      _gamesListMap[listName]!.add(item);
    }
  }

  @override
  void deleteFromList(String listName, dynamic item) {
    if (_gamesListMap[listName]?.contains(item as IgdbGetGamesList) ?? false) {
      _gamesListMap[listName]!.remove(item);
    }
  }

  @override
  void deleteList(String listName) {
    if (_gamesListMap.containsKey(listName)) {
      _gamesListMap.remove(listName);
    }
  }

  @override
  void saveToFile() {
    String jsonStrOfLists = json.encode(_gamesListMap);
    File file = File('/lib/tracking/gamingLists.json');
    file.writeAsStringSync(jsonStrOfLists);
  }

  @override
  void currentItem(item) {
    currentGame = item;
  }

  @override
  void getFromFile() {
    File file = File('/lib/tracking/gamingLists.json');
    String jsonStringOfLists = file.readAsStringSync();
    if (jsonStringOfLists != "") {
      Map<String, List<dynamic>> newlist =
          Map.castFrom(json.decode(jsonStringOfLists));
      newlist.forEach((key, value) {
        _gamesListMap.putIfAbsent(key, () => value as List<IgdbGetGamesList>);
      });
    }
  }

  @override
  List<String> getListNames() {
    List<String> listOfNames = [];
    listOfNames.addAll(_gamesListMap.keys);
    return listOfNames;
  }

  @override
  dynamic findItem(listName, item) {
    return _gamesListMap[listName]!.contains(item);
  }

  @override
  dynamic getList(String listName) {
    return _gamesListMap[listName];
  }

  @override
  int lengthOfList() {
    return _gamesListMap.length;
  }

  @override
  Map<String, bool> listsThatHaveItem(item) {
    Map<String, bool> hasItems = {};
    _gamesListMap.forEach((key, value) {
      if (value.contains(item)) {
        hasItems.addAll({key: true});
      } else {
        hasItems.addAll({key: false});
      }
    });
    return hasItems;
  }
}
// class TrackingBooks extends Tracking{
//   TrackingBooks._();
//   static final TrackingBooks _instance = TrackingBooks._();

//   static TrackingBooks get instance => _instance;
// }
// class TrackingMovies extends Tracking {
//   TrackingMovies._();
//   static final TrackingMovies _instance = TrackingMovies._();
//   static TrackingMovies get instance => _instance;

// }
// class TrackingShows extends Tracking {
//   TrackingShows._();
//   static final TrackingShows _instance = TrackingShows._();
//   static TrackingShows get instance => _instance;

// }
// class TrackingAnimes extends Tracking {
//   TrackingAnimes._();
//   static final TrackingAnimes _instance = TrackingAnimes._();
//   static TrackingAnimes get instance => _instance;

// }

class Data {
  Data._();
  static final Data _instance = Data._();

  static Data get instance => _instance;

  List<IgdbGetGamesList> gamesList = [];
  int offset = 0;
  int page = 0;

  void clearGamesList() {
    if (gamesList.isNotEmpty) {
      gamesList = [];
      offset = 0;
      page = 0;
    }
  }

  void updateGamesList(
      List<IgdbGetGamesList> newList, int newOffset, int newPage) {
    gamesList = newList;
    offset = newOffset;
    page = newPage;
  }
}
