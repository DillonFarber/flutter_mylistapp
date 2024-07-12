// ignore_for_file: slash_for_doc_comments
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylistapp/APIs/IGDB/igdb.dart';
import 'package:mylistapp/constants/routes.dart';
import 'package:mylistapp/tracking/tracking_lists.dart';
import 'package:mylistapp/utilities/MediaType.dart';

/* Component for the drawer of the appbar for views past the login */
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                CupertinoIcons.gamecontroller_alt_fill,
              ),
            ),
            DrawerListTitle(
              title: "Dashboard",
              icon: CupertinoIcons.home,
              press: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(dashboardRoute, (route) => false);
              },
            ),
            DrawerListTitle(
                title: "Games",
                icon: CupertinoIcons.game_controller,
                press: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(gamesRoute, (route) => false);
                }),
            DrawerListTitle(
                title: "Books", icon: CupertinoIcons.book, press: () {}),
            DrawerListTitle(
                title: "Movies & Shows",
                icon: CupertinoIcons.film,
                press: () {}),
            DrawerListTitle(
                title: "My List",
                icon: CupertinoIcons.square_list,
                press: () {}),
            DrawerListTitle(
                title: "Favorites", icon: CupertinoIcons.star, press: () {}),
            DrawerListTitle(
                title: "Search", icon: CupertinoIcons.search, press: () {}),
          ],
        ),
      ),
    );
  }
}

class DrawerListTitle extends StatelessWidget {
  const DrawerListTitle({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 10.0,
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

/* The component for the Dashboard Gridcell  */

class MyGridCellButton extends StatelessWidget {
  const MyGridCellButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.press});

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: press,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                offset: const Offset(5, 5),
                blurRadius: 1.0,
              )
            ],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: Theme.of(context).primaryIconTheme.size,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      );
    });
  }
}

class MyNewsList extends StatelessWidget {
  const MyNewsList({super.key, required this.newsHeadlines});

  final List<Headlines> newsHeadlines;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Text("")),
                  Expanded(child: Text("News:")),
                  Expanded(child: Text(""))
                ],
              ),
              for (var news in newsHeadlines)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(news.icon),
                    TextButton(
                      onPressed: news.press,
                      child: Text(news.headline),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}

class Headlines {
  const Headlines(
      {required this.press, required this.icon, required this.headline});
  final VoidCallback press;
  final String headline;
  final IconData icon;
}

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          const Expanded(child: Text("")),
          Expanded(
            child: InkWell(
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != "/prototype/") {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      prototypeRoute, (route) => false);
                }
              },
              child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.background,
                        offset: const Offset(5, 5),
                        blurRadius: 5.0,
                      )
                    ],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: const Icon(CupertinoIcons.home)),
            ),
          ),
          const Expanded(child: Text("")),
        ],
      ),
    );
  }
}

/**
 * The dialog will show when the search icon shows up and send them to a search 
 * view window with further showing filters and type of media. 
 */ //

class MyDialogSearch extends StatelessWidget {
  const MyDialogSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          EdgeInsets.fromLTRB(5, 5, 5, MediaType.height(context) - 150),
      child: TextField(
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        obscureText: false,
        decoration: InputDecoration(
            prefixIcon: const Icon(CupertinoIcons.search),
            filled: false,
            labelText: 'Search',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }
}

/*
  Floating top bar, display shows when scrolling 
  up but disappers during scroll down
 */

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      // color: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Builder(builder: (context) {
              return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(CupertinoIcons.bars));
            }),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    try {
                      return const MyDialogSearch();
                    } catch (e) {
                      devtools.log(e.toString());
                    }
                    return Dialog(
                      child: Column(
                        children: [
                          const Text("Error"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: const Text("Ok"))
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(CupertinoIcons.search_circle),
            ),
          )
        ],
      ),
    );
  }
}

class MyAnimatedTopBar extends StatefulWidget {
  const MyAnimatedTopBar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<StatefulWidget> createState() => _MyAnimatedTopBarState();
}

class _MyAnimatedTopBarState extends State<MyAnimatedTopBar> {
  bool _showingSearchBar = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      // color: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      child: _showingSearchBar
          ? searchTopBarState(context)
          : standardTopBarState(context, widget.title),
    );
  }

  Row standardTopBarState(BuildContext context, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(CupertinoIcons.bars));
          }),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {
              setState(() {
                _showingSearchBar = true;
              });
            },
            icon: const Icon(CupertinoIcons.search_circle),
          ),
        )
      ],
    );
  }

  Row searchTopBarState(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(
              backgroundColor: Colors.transparent,
              color: Colors.black,
            ),
            obscureText: false,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(CupertinoIcons.clear),
                  onPressed: () {
                    setState(() {
                      _showingSearchBar = false;
                    });
                  },
                ),
                suffixIcon: IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () {
                    setState(() {
                      _showingSearchBar = false;
                    });
                    // TODO: add search view; depending on what is given;
                    // Navigator.of(context).pushNamed("");
                  },
                ),
                filled: true,
                label: Text(
                  "Search",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
      ],
    );
  }
}

/*
  MyCard is used for the girdviews that show the cover of the media choosen
  with the ability to flip the card to see a summary and title with 
  some other info.
 */

class MyCard extends StatefulWidget {
  const MyCard({
    super.key,
    required this.id,
    required this.coverUrl,
    required this.artUrl,
    required this.name,
    required this.platforms,
    required this.listData,
    this.summary,
    required this.iconSolid,
    required this.iconHollow,
    required this.route,
    required this.data,
  });
  final int id;
  final String coverUrl;
  final String artUrl;
  final String name;
  final String platforms;
  final String? summary;
  final Tracking listData;
  final IconData? iconSolid;
  final IconData? iconHollow;
  final String route;
  final IgdbGetGamesList data;

  @override
  State<StatefulWidget> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool _isFlipped = false;
  bool _inAList = false;

  void isFlipCard(bool flip) {
    setState(() {
      _isFlipped = flip;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Add logic for determining if the game is part of lists and show corresponding icon

    return !_isFlipped
        ? Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(widget.route, arguments: widget.data),
                onDoubleTap: () => isFlipCard(true),
                child: Stack(alignment: Alignment.bottomRight, children: [
                  MyGameCoverBuilder(
                      coverUrl: widget.coverUrl,
                      artworkUrl: widget.artUrl,
                      name: widget.name),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  child: Column(
                                children: [
                                  Text("Lists",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(10),
                                    itemCount: widget.listData.lengthOfList(),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 300,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      //TODO: fix the rest of the dialog for adding, deleteing, creating list dialog box

                                      return;
                                    },
                                  ),
                                ],
                              ));
                            });
                      },
                      icon: (_inAList)
                          ? Icon(
                              widget.iconSolid,
                              shadows: List.generate(
                                10,
                                (index) => Shadow(
                                  blurRadius: 2,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            )
                          : Icon(
                              widget.iconHollow,
                              shadows: List.generate(
                                3,
                                (index) => Shadow(
                                  blurRadius: 2,
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                ]),
              ),
            ),
          )
        : Card(
            child: InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed(widget.route, arguments: widget.data),
              onDoubleTap: () => isFlipCard(false),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      widget.platforms,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(widget.summary ?? "",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          );
  }
}

class MyGameCoverBuilder extends StatelessWidget {
  const MyGameCoverBuilder({
    super.key,
    required this.coverUrl,
    required this.artworkUrl,
    required this.name,
  });
  final String coverUrl;
  final String artworkUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (coverUrl.isNotEmpty) {
        return FadeInImage(
          height: 600,
          width: 400,
          image: NetworkImage(
              "https://images.igdb.com/igdb/image/upload/t_cover_big/$coverUrl.jpg"),
          placeholder:
              const AssetImage("lib/assets/image_assets/controller.png"),
          imageErrorBuilder: (context, error, stackTrace) {
            return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(name),
                    const Image(
                        image: AssetImage(
                            "lib/assets/image_assets/controller.png"))
                  ],
                ));
          },
          fit: BoxFit.fill,
        );
      } else if (artworkUrl.isNotEmpty) {
        return FadeInImage(
          image: NetworkImage(
              "https://images.igdb.com/igdb/image/upload/t_cover_big/$artworkUrl.jpg"),
          placeholder:
              const AssetImage("lib/assets/image_assets/controller.png"),
          imageErrorBuilder: (context, error, stackTrace) {
            return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(name),
                    const Image(
                        image: AssetImage(
                            "lib/assets/image_assets/controller.png"))
                  ],
                ));
          },
          fit: BoxFit.fill,
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.topCenter,
            children: [
              const Image(
                  image: AssetImage("lib/assets/image_assets/controller.png")),
              Text(name, style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        );
      }
    });
  }
}

Map<int, String> month = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};

Map<int, List<String>> websiteName = {
  1: ["Home", "lib/assets/website_icons/home_button.png"],
  2: ["Wikia", "lib/assets/website_icons/social.png"],
  3: ["Wikipedia", "lib/assets/website_icons/social_2.png"],
  4: ["FaceBook", "lib/assets/website_icons/facebook.png"],
  5: ["Twitter", "lib/assets/website_icons/X_logo_32.png"],
  6: ["Twitch", "lib/assets/website_icons/twitch.png"],
  8: ["Instagram", "lib/assets/website_icons/Instagram_128.png"],
  9: ["YouTube", "lib/assets/website_icons/youtube.png"],
  10: ["iPhone", "lib/assets/website_icons/apple_2.png"],
  11: ["iPad", "lib/assets/website_icons/ipad.png"],
  12: ["Android", "lib/assets/website_icons/android.png"],
  13: ["Steam", "lib/assets/website_icons/64px-Steam_icon_logo.svg.png"],
  14: ["Reddit", "lib/assets/website_icons/reddit.png"],
  15: ["Itch", "lib/assets/website_icons/itch.io_32.png"],
  16: ["EpicGames", "lib/assets/website_icons/EpicGames_64.png"],
  17: ["GOG", "lib/assets/website_icons/gog_50.png"],
  18: ["Discord", "lib/assets/website_icons/discord_2.png"]
};

// TODO: Add Deep links for the website rows