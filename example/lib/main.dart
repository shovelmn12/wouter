// DATA
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
  const HomeScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.wouter.push("/people"),
            child: Text("See people"),
          ),
        ),
      );
}

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Wouter(
        base: "/people",
        child: WouterSwitch(
          routes: {
            "/": (context, arguments) => const MaterialPage(
                  key: ValueKey("all-people-screen"),
                  child: AllPeopleScreen(),
                ),
            r"/:id(\d+)": (context, arguments) => MaterialPage(
                  key: ValueKey("people-${arguments["id"]}-screen"),
                  child: PersonDetailsScreen(
                    person: people[arguments["id"]]!,
                  ),
                ),
            "/:_(.*)": (context, arguments) => const MaterialPage(
                  key: ValueKey("people-redirect-screen"),
                  child: Redirect(),
                ),
          },
        ),
      );
}

class AllPeopleScreen extends StatelessWidget {
  const AllPeopleScreen();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("People"),
        ),
        body: ListView(
          children: people.values
              .map(
                (person) => ListTile(
                  title: Text(
                      "${person["name"]["first"]} ${person["name"]["last"]}"),
                  onTap: () => context.wouter.push("./${person["_id"]}"),
                ),
              )
              .toList(),
        ),
      );
}

class PersonDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> person;

  const PersonDetailsScreen({
    required this.person,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
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

class MyApp extends StatelessWidget {
  final delegate = WouterRouterDelegate(
    child: WouterSwitch(
      routes: {
        "/": (context, arguments) => const MaterialPage(
              key: ValueKey("home-screen"),
              child: HomeScreen(),
            ),
        "/people/:_(.*)": (context, arguments) => const MaterialPage(
              key: ValueKey("people-screen"),
              child: PeopleScreen(),
            ),
        "/:_(.*)": (context, arguments) => const MaterialPage(
              key: ValueKey("redirect-screen"),
              child: Redirect(),
            ),
      },
    ),
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: delegate,
        routeInformationParser: const WouterRouteInformationParser(),
        backButtonDispatcher: WouterBackButtonDispatcher(
          delegate: delegate,
        ),
      );
}

void main() => runApp(MyApp());
