import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylistapp/components/components.dart';
import 'dart:developer' as devtools show log;
import 'package:mylistapp/constants/routes.dart';
import 'package:mylistapp/services/auth/auth_exceptions.dart';
import 'package:mylistapp/services/auth/auth_service.dart';
import 'package:mylistapp/utilities/MediaType.dart';
import 'package:mylistapp/utilities/show_error_log.dart';

class ListsView extends StatefulWidget {
  const ListsView({super.key});

  @override
  State<StatefulWidget> createState() => _ListsViewState();
}

class _ListsViewState extends State<ListsView> {
  @override
  void dispose() {
    super.dispose();
  }

  final int count = 0;
  final List<String> myLists =
      List.generate(50, (index) => (index + 1).toString());

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
                    child: Text('Lists',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: Text(""),
                )
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: myLists.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(myLists[index]),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
