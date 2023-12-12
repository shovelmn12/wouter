import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

const Map<String, Map<String, dynamic>> people = {
  "1": {
    "_id": "1",
    "picture": "http://placehold.it/32x32",
    "age": 30,
    "eyeColor": "green",
    "name": {
      "first": "Tran",
      "last": "Perry",
    },
    "phone": "+1 (907) 401-2166",
    "address": "892 Rogers Avenue, Dragoon, Colorado, 8508",
    "about":
        "Duis voluptate qui officia ut esse reprehenderit dolore. Cillum elit elit minim consectetur dolore elit eiusmod ad id deserunt. Culpa magna fugiat laboris tempor duis consequat. Sit do laboris commodo nisi commodo ullamco Lorem officia commodo non. Dolor eu cupidatat non est voluptate. Labore ut occaecat irure quis eiusmod aliquip sunt voluptate nulla elit ut ex voluptate. Est proident est eiusmod aute consectetur pariatur magna deserunt do fugiat et reprehenderit."
  },
  "2": {
    "_id": "2",
    "picture": "http://placehold.it/32x32",
    "age": 24,
    "eyeColor": "blue",
    "name": {
      "first": "Hoffman",
      "last": "Blanchard",
    },
    "phone": "+1 (980) 460-2862",
    "address": "430 Times Placez, Williston, Alaska, 175",
    "about":
        "Proident ut labore in duis excepteur excepteur aute. Pariatur nostrud sint aute velit id. Et in in eu excepteur et cillum elit elit elit reprehenderit consectetur quis nisi aute. Elit sit adipisicing adipisicing veniam ad tempor sint dolore consectetur consectetur nulla occaecat ipsum. Dolor id magna culpa laborum deserunt consequat commodo nisi ullamco."
  },
  "3": {
    "_id": "3",
    "picture": "http://placehold.it/32x32",
    "age": 21,
    "eyeColor": "blue",
    "name": {
      "first": "Guerra",
      "last": "Gay",
    },
    "phone": "+1 (883) 505-3110",
    "address": "918 Wallabout Street, Harviell, Missouri, 6711",
    "about":
        "Reprehenderit elit et adipisicing reprehenderit pariatur ut dolor proident laborum dolore reprehenderit consectetur officia. Cillum nostrud velit consectetur nulla ea excepteur quis in enim fugiat. Anim proident commodo aliquip ipsum elit ut qui proident."
  },
  "4": {
    "_id": "4",
    "picture": "http://placehold.it/32x32",
    "age": 26,
    "eyeColor": "green",
    "name": {"first": "Fulton", "last": "Velasquez"},
    "phone": "+1 (885) 434-3200",
    "address": "586 Verona Place, Goldfield, Utah, 6121",
    "about":
        "Occaecat officia culpa ad id. Ipsum voluptate laboris eiusmod anim exercitation ipsum est in labore ea ullamco. Eu aute duis pariatur non esse. Qui commodo ex elit laborum deserunt aliqua ipsum tempor qui do eiusmod exercitation."
  }
};

// SCREENS
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wouter = context.wouter;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => wouter.push("/people"),
          child: Text("See people"),
        ),
      ),
    );
  }
}

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Wouter(
        key: const ValueKey("people-wouter"),
        base: "/people",
        child: WouterSwitch(
          key: const ValueKey("people-switch"),
          routes: {
            "/": (context, arguments) => const AllPeopleScreen(
                  key: ValueKey("all-people-screen"),
                ),
            r"/:id(\d+)": (context, arguments) => PersonDetailsScreen(
                  key: ValueKey("people-${arguments["id"]}-screen"),
                  person: people[arguments["id"]]!,
                ),
            "/:_(.*)": (context, arguments) => const Redirect(
                  key: ValueKey("people-redirect-screen"),
                ),
          },
        ),
      );
}

class AllPeopleScreen extends StatelessWidget {
  const AllPeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wouter = context.wouter;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => wouter.pop(),
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text("People"),
      ),
      body: ListView(
        children: people.values
            .map(
              (person) => ListTile(
                title: Text(
                    "${person["name"]["first"]} ${person["name"]["last"]}"),
                onTap: () => wouter.push("./${person["_id"]}"),
              ),
            )
            .toList(),
      ),
    );
  }
}

class PersonDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> person;

  const PersonDetailsScreen({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wouter = context.wouter;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => wouter.pop(),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("${person["name"]["first"]} ${person["name"]["last"]}"),
      ),
      body: ListView(
        children: person.entries
            .where((element) => element.key != "name" && element.key != "_id")
            .map(
              (e) => ListTile(
                title: Row(
                  children: [
                    Text(
                      "${e.key}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text("${e.value}"),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Router extends StatelessWidget {
  const _Router();

  @override
  Widget build(BuildContext context) => WouterSwitch(
        routes: {
          "/": (context, arguments) => const HomeScreen(
                key: ValueKey("home-screen"),
              ),
          "/people/:_(.*)": (context, arguments) => const PeopleScreen(
                key: ValueKey("people-screen"),
              ),
          "/:_(.*)": (context, arguments) => const Redirect(
                key: ValueKey("redirect-screen"),
              ),
        },
      );
}

class MyApp extends StatelessWidget {
  final GlobalKey<WouterState> _wouterKey = GlobalKey();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: WouterConfig(
          key: _wouterKey,
          builder: (context) => Wouter(
            key: _wouterKey,
            child: _Router(),
          ),
        ),
      );
}

void main() => runApp(MyApp());
