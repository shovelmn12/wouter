# wouter - BETA

<a href="https://pub.dev/packages/wouter"><img src="https://img.shields.io/pub/v/wouter.svg" alt="pub"></a>

#### Docs WIP

- [Features](#features)
- [Widgets](#widgets)
  - [Wouter](#wouter)
  - [WouterSwitch](#wouterswitch)
- [Concepts](#concepts)
- [Example](#example)

Supercharge your routing with wouter, simple yet advanced and fully customizable routing package.

Coming from React.js, where navigation is made very easy, Navigator 2.0 seems really complex.
Wouter is trying to bring back the easy of use of Navigator 1.0 to Navigator 2.0

Wouter is an implementation of the npm package: [wouter](https://www.npmjs.com/package/wouter)

## Features:
- Navigator 1.0 like API
- Easy migration from Navigator 1.0
- No boilerplate, no need to build special classes for locations/routes etc...
- Regexp support using [path_to_regexp](https://pub.dev/packages/path_to_regexp)
- Relative paths (```push("../../here")```, ```replace("../there")```) using [```normalize()```](https://pub.dev/documentation/path/latest/path/normalize.html) from [path](https://pub.dev/packages/path)
- Following everything is a widget, Wouter is a widget and its child is a Widget
- Nested and Parallel (multiple Wouters in a Column or a Row) Wouters
- Base paths
- Flexible navigators (Switch, Row, Column etc...) and easily build your own navigator
- Using ```const``` everywhere
- Uses [freezed](https://pub.dev/packages/freezed) to generate classes

## Widgets

Because Wouter follows everything is a widget concept it is easy to include Wouter in your app.

### Wouter

Wouter is used to encapsulate a group of paths which has the same base path

```dart
const Wouter({
    Key? key,
    required Widget child,
    PathMatcherBuilder matcher = PathMatchers.regexp,
    String base = "",
  })
```

```dart
MyWidget(
  child: Wouter(
    base: "/items",
    child: WouterSwitch(
      routes: {
        "/": (context, arguments) => const MaterialPage(
              key: ValueKey("items")
              child: ItemsScreen(),
            ),
      // matching and parsing id as int, no need to parse id from string to int later
      r"/:id(\d+)": (context, arguments) => MaterialPage(
              key: ValueKey("items-${arguments["id"]}")
              child: ItemProvider(
                id: arguments["id"],
                child: const ItemScreen(),
              )
            ),
      // match anything else to redirect back to items screen
      "/:_(.*)": (context, arguments) => const MaterialPage(
              key: ValueKey("redirect")
              child: Redirect(
                to: "/",
              ),
            ),  
      }
    )
  )
)
```

### WouterSwitch

WouterSwitch is used for switching between a set of routes. Each route is defined by regexp

```dart
const WouterSwitch({
    Key? key,
    required Map<String, WouterRouteBuilder<T>> routes,
    List<NavigatorObserver> observers = const [],
    TransitionDelegate<T> transition = const DefaultTransitionDelegate(),
  })
```

```dart
MyWidget(
  child: WouterSwitch(
    routes: {
      "/": (context, arguments) => const MaterialPage(
              key: ValueKey("home")
              child: HomeScreen(),
            ),
      // matching and parsing id as int, no need to parse id from string to int later
      r"/:id(\d+)": (context, arguments) => MaterialPage(
              key: ValueKey("items-${arguments["id"]}")
              child: ItemProvider(
                id: arguments["id"],
                child: const ItemScreen(),
              )
            ),
      // match anything else to redirect back to home
      "/:_(.*)": (context, arguments) => const MaterialPage(
              key: ValueKey("redirect")
              child: Redirect(
                to: "/",
              ),
            ),     
    }
  )
)
```

## Concepts

Wouter is base on single source of truth. There is only one [```Router```](https://api.flutter.dev/flutter/widgets/Router-class.html) at the base of the app (using [```WidgetsApp.router```](https://api.flutter.dev/flutter/widgets/WidgetsApp/WidgetsApp.router.html) and [```RouterDelegate```](https://api.flutter.dev/flutter/widgets/RouterDelegate-class.html)). All children Wouters listen to changes on their parent and reacting to changes of the current route, when there is not change not work is being done.
Wouter is using [```ChangeNotifier```](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) to listen and react to changes.

## Example

```dart
class MyApp extends StatelessWidget {
  final delegate = WouterRouterDelegate(
    child: WouterSwitch(
      routes: {
        "/": (context, arguments) => const MaterialPage(
              key: ValueKey("home")
              child: HomeScreen(),
            ),
        "/people": (context, arguments) => const MaterialPage(
              key: ValueKey("people")
              child: PeopleScreen(),
            ),
        "/:_(.*)": (context, arguments) => const MaterialPage(
              key: ValueKey("redirect")
              child: Redirect(
                to: "/",
              ),
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
```
