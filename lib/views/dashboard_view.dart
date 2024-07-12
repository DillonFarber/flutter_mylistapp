import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylistapp/APIs/IGDB/igdb.dart';
import 'package:mylistapp/APIs/IGDB/igdb_network_call.dart';
import 'package:mylistapp/components/components.dart';
import 'package:mylistapp/constants/routes.dart';
import 'dart:developer' as devtools show log;
import 'package:mylistapp/utilities/MediaType.dart';
import 'package:mylistapp/tracking/tracking_lists.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {

  List<IgdbGetGamesList> data = [];
  int offset = 0;
  Data dataTracking = Data.instance;
  TrackingGames gameListData = TrackingGames.instance;

  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    IgdbCall.fetchBearer();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const SafeArea(
          child: Row(
        children: [
          MyDrawer(),
        ],
      )),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
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
                    child: Text('Daashboard',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const MyDialogSearch()),
                    icon: const Icon(CupertinoIcons.search),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              children: [
                  Card(
                    child: SizedBox(
                      height: 250,
                      width: 150.0,
                      child: Text("Current Game", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Text("Current Book", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Text("Current Show", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Text("Next Movie", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                    ),
                  ),
                  Card(
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Text("Current Anime", style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,),
                    ),
                  )
              ],
            ),),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: MediaType.isMobile(context) ? 2 : 4,
              padding: const EdgeInsets.all(10),
              children: [
                MyGridCellButton(
                  title: "My Lists",
                  icon: CupertinoIcons.list_dash,
                  press: () {
                    Navigator.of(context).pushNamed(listsRoute);
                  },
                ),
                MyGridCellButton(
                  title: "Favorites",
                  icon: CupertinoIcons.heart,
                  press: () {
                    Navigator.of(context).pushNamed(listsRoute);
                  },
                ),
                MyGridCellButton(
                    title: "Discover",
                    icon: CupertinoIcons.star_circle,
                    press: () {
                      Navigator.of(context).pushNamed(prototypeRoute, arguments: {
                        'gamesLists' : gameListData
                      });
                    }),
                MyGridCellButton(
                    title: "News",
                    icon: CupertinoIcons.news,
                    press: () {
                      Navigator.of(context).pushNamed(listsRoute);
                    }),
                MyGridCellButton(
                  title: "Games",
                  icon: CupertinoIcons.game_controller_solid,
                  press: () async {
                    Navigator.of(context).pushNamed(gamesRoute, arguments: {
                      'data' : dataTracking, 
                      'gamesLists': gameListData,
                    });
                    devtools.log(dataTracking.gamesList.length.toString());
                  },
                ),
                MyGridCellButton(
                  title: "Books",
                  icon: CupertinoIcons.book_solid,
                  press: () {
                    Navigator.of(context).pushNamed(listsRoute);
                  },
                ),
                MyGridCellButton(
                  title: "Anime",
                  icon: CupertinoIcons.eyeglasses,
                  press: () {
                    Navigator.of(context).pushNamed(listsRoute);
                  },
                ),
                MyGridCellButton(
                  title: "Movies & Shows",
                  icon: CupertinoIcons.film,
                  press: () {
                    Navigator.of(context).pushNamed(listsRoute);
                  },
                ),
                
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
