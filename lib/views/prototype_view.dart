import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mylistapp/APIs/IGDB/igdb.dart';
import 'package:mylistapp/components/components.dart';
import 'dart:developer' as devtools show log;
import 'package:mylistapp/APIs/IGDB/igdb_network_call.dart';
import 'package:mylistapp/constants/routes.dart';

class PrototypeView extends StatefulWidget {
  const PrototypeView({super.key});

  @override
  State<StatefulWidget> createState() => _PrototypeState();
}

class _PrototypeState extends State<PrototypeView> {
  int _currentOffset = 0;
  int _page = 0;
  final int _pageSize = 50;
  final List<IgdbGetGamesList> _games = [];
  bool _isLoading = false;
  late ScrollController _scrollController;
  bool _isScrolling = false;
  bool _appBarShowing = true;
  bool _isFirst = true;
  dynamic args;

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadMoreData();
    _setupScrollController();
  }

  Future<void> _loadMoreData() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentOffset = _pageSize * _page;
      devtools.log(_currentOffset.toString());
      _page += 1;
      var data = await IgdbCall.fetchGamesList(
          _currentOffset.toString(), _pageSize.toString(), null);
      setState(() {
        _games.addAll((data ?? []));
        _isLoading = false;
        devtools.log(_games.length.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirst) {
      args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
          as Map;
      _isFirst = false;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      drawer: const SafeArea(
          child: Row(
        children: [
          MyDrawer(),
        ],
      )),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: _appBarShowing ? 56.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _appBarShowing
                  ? const MyAnimatedTopBar(
                      title: "Discover",
                    )
                  : null,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: _games.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String platforms = "";
                        for (var plat in _games[index].platforms) {
                          if (_games[index]
                                  .platforms
                                  .last
                                  .abbreviation
                                  .toString() !=
                              plat.abbreviation.toString()) {
                            platforms += "${plat.abbreviation.toString()}, ";
                          } else {
                            platforms += "${plat.abbreviation}";
                          }
                        }
                        return MyCard(
                          id: _games[index].id,
                          name: _games[index].name,
                          platforms: platforms,
                          artUrl: (_games[index].artworks!.isNotEmpty)
                              ? _games[index].artworks![0].imageId.toString()
                              : "",
                          coverUrl: (_games[index].cover?.imageId ?? ""),
                          summary:
                              _games[index].storyline ?? _games[index].summary,
                          listData: args['gamesLists'],
                          iconSolid: CupertinoIcons.game_controller_solid,
                          iconHollow: CupertinoIcons.game_controller,
                          data: _games[index],
                          route: gameCardRoute,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const MyBottomNavigationBar(),
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
        !_scrollController.position.outOfRange) {
      _loadMoreData();
    }

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
