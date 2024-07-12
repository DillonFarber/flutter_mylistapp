import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:mylistapp/APIs/IGDB/igdb.dart';
import 'package:mylistapp/components/components.dart';
import 'dart:developer' as devtools show log;
import 'package:mylistapp/utilities/MediaType.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GameCardView extends StatefulWidget {
  const GameCardView({super.key});

  @override
  State<StatefulWidget> createState() => _GameCardViewState();
}

class _GameCardViewState extends State<GameCardView> {
  bool _loaded = false;
  bool _appBarShowing = true;
  late IgdbGetGamesList _game;
  bool _ifOpen = false;
  bool _ifOpenStory = false;

  String date = "";
  String developer = "";
  String supporting = "";
  String publisher = "";

  List<String> videoIDs = [];
  List<String> imageURL = [];

  late MaterialColor totalRatColor;
  late MaterialColor ratColor;

  late ScrollController _scrollController;
  bool _isScrolling = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setupScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      _game = ModalRoute.of(context)?.settings.arguments as IgdbGetGamesList;
      _loaded = true;

      int day =
          DateTime.fromMicrosecondsSinceEpoch(_game.firstReleaseDate! * 1000000)
              .day;
      int mnth =
          DateTime.fromMicrosecondsSinceEpoch(_game.firstReleaseDate! * 1000000)
              .month;
      int yr =
          DateTime.fromMicrosecondsSinceEpoch(_game.firstReleaseDate! * 1000000)
              .year;
      date = "${month[mnth]} $day, $yr";

      for (var company in _game.involvedCompanies ?? <InvolvedCompany>[]) {
        if (company.developer ?? false) {
          developer += company.company?.name ?? "";
        }
        if (company.supporting ?? false) {
          supporting += "${company.company?.name}\n";
        }
        if (company.publisher ?? false) {
          publisher += company.company?.name ?? "";
        }
      }
      if (_game.rating != null) {
        if (_game.rating! >= 80) {
          ratColor = Colors.green;
        } else if (_game.rating! >= 65 && _game.rating! < 80) {
          ratColor = Colors.yellow;
        } else {
          ratColor = Colors.red;
        }
      }
      if (_game.totalRating != null) {
        if (_game.totalRating! >= 80) {
          totalRatColor = Colors.green;
        } else if (_game.totalRating! >= 65 && _game.totalRating! < 80) {
          totalRatColor = Colors.yellow;
        } else {
          totalRatColor = Colors.red;
        }
      }

      for (var image in _game.artworks ?? <Cover>[]) {
        imageURL.add(image.imageId ?? "");
      }
      for (var image in _game.screenshots ?? <Cover>[]) {
        imageURL.add(image.imageId ?? "");
      }

      for (var video in _game.videos ?? <Video>[]) {
        videoIDs.add(video.videoId ?? "");
        devtools.log(video.videoId ?? "");
      }
    }

    return !_loaded
        ? Scaffold(
            body: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                )))
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primary,
            drawer: const SafeArea(
                child: Row(
              children: [
                MyDrawer(),
              ],
            )),
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaType.width(context),
                    height: MediaType.height(context),
                    child: FadeInImage(
                        fit: BoxFit.fill,
                        placeholder: const AssetImage(
                            "lib/assets/image_assets/controller.png"),
                        image: NetworkImage(
                            scale: 1.0,
                            "https://images.igdb.com/igdb/image/upload/t_1080p/${_game.artworks?[0].imageId ?? ""}.jpg")),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(MediaType.width(context) / 30,
                        15, MediaType.width(context) / 30, 15),
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: (MediaType.isLandscape(context))
                                  ? MediaType.height(context) / 2
                                  : MediaType.height(context) / 4,
                              width: (MediaType.isLandscape(context))
                                  ? MediaType.width(context) / 5
                                  : MediaType.width(context) / 3,
                              child: FadeInImage(
                                  fit: BoxFit.fill,
                                  placeholder: const AssetImage(
                                      "lib/assets/image_assets/controller.png"),
                                  image: NetworkImage(
                                      "https://images.igdb.com/igdb/image/upload/t_cover_big/${_game.cover?.imageId ?? ""}.jpg")),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Text(
                                      _game.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        shadows: List.generate(
                                          10,
                                          (index) => Shadow(
                                            blurRadius: 2,
                                            color:
                                                Theme.of(context).canvasColor,
                                          ),
                                        ),
                                        fontSize: 30,
                                        fontStyle: FontStyle.normal,
                                        fontFamily: "buffalo",
                                      ),
                                      softWrap: true,
                                      overflow: null,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Platforms: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            shadows: List.generate(
                                              10,
                                              (index) => Shadow(
                                                blurRadius: 2,
                                                color: Theme.of(context)
                                                    .canvasColor,
                                              ),
                                            ),
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: "buffalo",
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Text("      "),
                                            for (var plat in _game.platforms)
                                              Text(
                                                "${plat.abbreviation} ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  shadows: List.generate(
                                                    10,
                                                    (index) => Shadow(
                                                      blurRadius: 2,
                                                      color: Theme.of(context)
                                                          .canvasColor,
                                                    ),
                                                  ),
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.normal,
                                                  fontFamily: "buffalo",
                                                ),
                                              )
                                          ],
                                        ),
                                        Text(
                                          "Release Date: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            shadows: List.generate(
                                              10,
                                              (index) => Shadow(
                                                blurRadius: 2,
                                                color: Theme.of(context)
                                                    .canvasColor,
                                              ),
                                            ),
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: "buffalo",
                                          ),
                                        ),
                                        Text(
                                          "        $date",
                                          style: TextStyle(
                                            color: Colors.white,
                                            shadows: List.generate(
                                              10,
                                              (index) => Shadow(
                                                blurRadius: 2,
                                                color: Theme.of(context)
                                                    .canvasColor,
                                              ),
                                            ),
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                            fontFamily: "buffalo",
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(75, 255, 255, 255),
                          ),
                          child: Row(
                            children: [
                              for (var website in _game.websites ?? <Website>[])
                                if (website.category == 1 ||
                                    website.category == 13 ||
                                    website.category == 16 ||
                                    website.category == 17 ||
                                    website.category == 18)
                                  InkWell(
                                    onTap: () {},
                                    child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.all(2),
                                            child: Image.asset(
                                              websiteName[website.category]
                                                      ?[1] ??
                                                  "lib/assets/website_icons/unknown.png",
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    "lib/assets/website_icons/EpicGames_64.png");
                                              },
                                            ))),
                                  ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 0),
                                        alignment: Alignment.centerRight,
                                        child: CircularPercentIndicator(
                                          radius: 35,
                                          percent: (_game.rating ?? 0) / 100,
                                          progressColor: ratColor,
                                          lineWidth: 8,
                                          center: Text(
                                            "IGN:\n${(_game.rating?.round() ?? "unkn")}%",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 0, 0),
                                        alignment: Alignment.centerRight,
                                        child: CircularPercentIndicator(
                                          radius: 35,
                                          lineWidth: 8,
                                          percent:
                                              (_game.totalRating ?? 0) / 100,
                                          progressColor: totalRatColor,
                                          center: Text(
                                            "Aggr.\n${(_game.totalRating?.round() ?? 0)}%",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_game.storyline != null)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(190, 255, 255, 255),
                            ),
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Storyline: ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    "${_game.storyline}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                    maxLines: (_ifOpenStory) ? null : 4,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        if (_ifOpenStory) {
                                          setState(() {
                                            _ifOpenStory = false;
                                          });
                                        } else {
                                          setState(() {
                                            _ifOpenStory = true;
                                          });
                                        }
                                      },
                                      child: (_ifOpenStory)
                                          ? const Text(
                                              "less..",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          : const Text("read more..",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                    ),
                                  ),
                                ]),
                          ),
                        if (_game.summary != null)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(190, 255, 255, 255),
                            ),
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Summary: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${_game.summary}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                    maxLines: (_ifOpen) ? null : 4,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        if (_ifOpen) {
                                          setState(() {
                                            _ifOpen = false;
                                          });
                                        } else {
                                          setState(() {
                                            _ifOpen = true;
                                          });
                                        }
                                      },
                                      child: (_ifOpen)
                                          ? const Text(
                                              "less..",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          : const Text("read more..",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                    ),
                                  ),
                                ]),
                          ),
                        Container(
                          alignment: Alignment.center,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: videoIDs.length,
                              itemExtent: 350,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                YoutubePlayerController controller =
                                    YoutubePlayerController(
                                  initialVideoId: videoIDs[index],
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: true,
                                    disableDragSeek: true,
                                  ),
                                );
                                return Container(
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: YoutubePlayer(
                                    onReady: () {
                                      setState(() {});
                                    },
                                    onEnded: (metaData) {
                                      setState(() {
                                        controller.reload();
                                      });
                                    },
                                    controller: controller,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: imageURL.length,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: MediaType.width(context),
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: FadeInImage(
                                        image: NetworkImage(
                                          "https://images.igdb.com/igdb/image/upload/t_1080p/${imageURL[index]}.jpg",
                                        ),
                                        placeholder: const AssetImage(
                                          "lib/assets/image_assets/ghost_of_tsushima_logo_4k_p1_240x320.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(190, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: LayoutGrid(
                            columnGap: 10,
                            rowGap: 10,
                            areas: '''
                                  name  content
                                  name1 content1
                                  name2 content2
                                  name3 content3
                                  name4 content4
                                  name5 content5
                                  name6 content6
                                  name7 content7
                                  name8 content8
                                  name9 content9
                                  name10 content10
                                  name11 content11
                                  ''',
                            columnSizes: const [
                              auto,
                              auto,
                            ],
                            rowSizes: const [
                              auto,
                              auto,
                              auto,
                              auto,
                              auto,
                              auto,
                              auto,
                              auto,
                              auto,
                              auto,
                              auto,
                              auto
                            ],
                            children: [
                              gridArea('name').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text("Release Dates: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              )),
                              gridArea('content').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var release
                                      in _game.releaseDates ?? <ReleaseDate>[])
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          release.platform?.name ?? "",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "     ${release.human}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              )),
                              gridArea('name1').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text("Genre: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )),
                              gridArea('content1').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var genre
                                      in _game.genres ?? <GameMode>[])
                                    Text(genre.name ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ))
                                ],
                              )),
                              gridArea('name2').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text(
                                  "Player Perspectives: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                              gridArea('content2').containing(Column(
                                children: [
                                  for (var perspectives
                                      in _game.playerPerspectives ??
                                          <Keyword>[])
                                    Text(
                                      perspectives.name ?? "",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                ],
                              )),
                              gridArea('name3').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text(
                                  "Companies: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )),
                              gridArea('content3').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (developer != "")
                                    const Text("Developer: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "buffalo",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  Text(
                                    "     $developer",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "buffalo",
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (publisher != "")
                                    const Text("Publisher: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "buffalo",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  Text(
                                    "     $publisher",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "buffalo",
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (supporting != "")
                                    const Text("Supporting: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "buffalo",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  Text(
                                    "    $supporting",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: "buffalo",
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )),
                              gridArea('name4').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text(
                                  "Keywords: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                              gridArea('content4').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var keywords
                                      in _game.keywords ?? <Keyword>[])
                                    Text(keywords.name ?? "",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        )),
                                ],
                              )),
                              gridArea('name5').containing(Container(
                                  alignment: Alignment.topRight,
                                  child: const Text(
                                    "Themes: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ))),
                              gridArea('content5').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var theme
                                      in _game.themes ?? <GameMode>[])
                                    Text(
                                      theme.name ?? "",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                ],
                              )),
                              gridArea('name6').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text(
                                  "Alternative Names: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                              gridArea('content6').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var altName in _game.alternativeNames ??
                                      <AlternativeName>[])
                                    Text(altName.name ?? "",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                ],
                              )),
                              gridArea('name7').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text(
                                  "Game Modes: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                              gridArea('content7').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (var mode
                                      in _game.gameModes ?? <GameMode>[])
                                    Text(
                                      mode.name ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
                              )),
                              gridArea('name8').containing(Container(
                                alignment: Alignment.topRight,
                                child: const Text(
                                  "Game Localizations: ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                              gridArea('content8').containing(Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var gameL in _game.gameLocalizations ??
                                      <GameLocalization>[])
                                    Text(
                                      gameL.name ?? "",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                ],
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _setupScrollController() {
    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrolling) {
        _isScrolling = true;
        _appBarShowing = false;
        setState(() {});
      }
    }

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {}

    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrolling) {
        _isScrolling = false;

        _appBarShowing = true;
        setState(() {});
      }
    }
  }
}



// Column(
//   children: [
//     if (_game.releaseDates != null)
//       for (var dates
//           in _game.releaseDates ?? <ReleaseDate>[])
//         Text(
//             "${dates.platform?.name}\n ${dates.human}")
//   ],
// )