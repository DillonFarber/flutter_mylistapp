import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mylistapp/APIs/IGDB/igdb.dart';
import 'package:mylistapp/components/components.dart';
import 'dart:developer' as devtools show log;
import 'package:mylistapp/APIs/IGDB/igdb_network_call.dart';
import 'package:mylistapp/tracking/tracking_lists.dart';

class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<StatefulWidget> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  int _currentOffset = 0;
  int _page = 0;
  final int _pageSize = 50;
  final List<IgdbGetGamesList> _data = [];
  bool _isLoading = false;
  //Todo: fix the where args? or base of prefrencees
  // String _whereArgs = "";
  late ScrollController _scrollController;
  bool _isScrolling = false;
  bool _appBarShowing = true;
  bool _isFirst = true;
  Data? tracking;

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

  Future<void> _loadMoreData() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentOffset = _pageSize * _page;
      devtools.log(_currentOffset.toString());
      _page += 1;
      var data = await IgdbCall.fetchGamesList(
          _currentOffset.toString(), _pageSize.toString(), null);
      _currentOffset = _pageSize * _page;
      setState(() {
        _data.addAll((data ?? []));
        _isLoading = false;
        tracking?.updateGamesList(_data, _currentOffset, _page);
        devtools.log(_data.length.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirst) {
      _isFirst = false;
      final args = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      tracking = args['data'] as Data;
      if (tracking!.gamesList.isEmpty) {
        _loadMoreData();
        devtools.log("trackingList empty");
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          drawer: const SafeArea(
              child: Row(
            children: [
              MyDrawer(),
            ],
          )),
          body: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                    ))
              ]),
        );
      } else {
        _currentOffset = tracking!.offset;
        _data.addAll(tracking!.gamesList);
        _page = tracking!.page;
      }
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
              child: const MyAnimatedTopBar(title: "Games"),
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
                      itemCount: _data.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        String? imageId;
                        String? url;
                        int flag = 0;
                        if (_data[index].cover?.imageId != null) {
                          imageId = _data[index].cover?.imageId;
                          url =
                              "https://images.igdb.com/igdb/image/upload/t_cover_big/$imageId.jpg";
                        } else if (_data[index].artworks!.isNotEmpty) {
                          flag = 1;
                          imageId ??= _data[index].artworks?[0].imageId;
                          url =
                              "https://images.igdb.com/igdb/image/upload/t_cover_big/$imageId.jpg";
                        } else {
                          flag = 2;
                        }
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MyGameCoverBuilder(
                              flag: flag,
                              url: url,
                              data: _data,
                              index: index,
                            ));
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

class MyGameCoverBuilder extends StatelessWidget {
  const MyGameCoverBuilder({
    super.key,
    required this.flag,
    required this.index,
    required this.url,
    required List<IgdbGetGamesList> data,
  }) : _data = data;

  final int flag;
  final int index;
  final String? url;
  final List<IgdbGetGamesList> _data;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (flag == 0) {
        return Stack(
          children: [
            FadeInImage(
              image: NetworkImage(url!),
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
                        Text(_data[index].name),
                        const Image(
                            image: AssetImage(
                                "lib/assets/image_assets/controller.png"))
                      ],
                    ));
              },
              fit: BoxFit.fill,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.game_controller))
          ],
        );
      } else if (flag == 1) {
        return FadeInImage(
          image: NetworkImage(url!),
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
                    Text(_data[index].name),
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
              Text(_data[index].name,
                  style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        );
      }
    });
  }
}
