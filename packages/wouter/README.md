# wouter - BETA

<a href="https://pub.dev/packages/wouter"><img src="https://img.shields.io/pub/v/wouter.svg" alt="pub"></a>

#### Docs WIP

- [Motivation](#motivation)
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

## Motivation

You are probably asking yourself why? why to write another routing package, there are tons of libraries out there and they are working fine. Well I tried some of them and their are all lacking in few things:
- Boilerplate

  to use any of the other packages I always had to write extra code:
  ```dart
  ARouter(
    routes: [
      ARoute(
        path: "/here",
        // or
        paths: ["/here", "/and/there"],
        // or
        path: "/there",
        subpaths: ["/there/hello"]
        // some widget or widget builder
      )
    ],
  )
  ```
  so if, for example, I would like to expose a Provider at certain node of my widgets tree i'll need to write even more code to try and structure my paths depending on the package. sometimes adding a lot more complexity than needed (we do want to hit that 60 FPS).

  Using Navigator 1.0 its fine and easy to use and do such a thing, because Navigator 1.0 was a widget, just like any other widget, I could just put another Navigator where ever I wanted and just inject data in a specific node in my widgets tree, without writing boilerplate or change all my structure.
  ```dart
  MyWidget(
    child: SomeProvider(
        child: Navigator(
        routes: {
          "": (context) => MyChildWidget()
        }
      )
    )
  )
  ```
  The single thing that Navigator 1.0 was missing in my eyes is that I couldn't (I could but it was very complex) control 2 different navigators together to create a more reactive UI for the user.
  Like mounting widgets depending on the current route, doing such a thing with more than 1 navigator is complex.
  Well Wouter can do that
  ```dart
  MyWidget1(
    child: SomeProvider1(
        child: WouterSwitch(
        routes: {
          "/a": (context, arguments) => ...,
          "/b": (context, arguments) => ...,
        }
      )
    )
  )
  ```
  ```dart
  MyWidget2(
    child: SomeProvider2(
        child: WouterSwitch(
        routes: {
          "/a": (context, arguments) => ...,
          "/b": (context, arguments) => ...,
        }
      )
    )
  )
  ```
  If the path is ```/a``` both ```WouterSwitch``` under ```MyWidget1``` and ```MyWidget2``` will match for ```/a```. ```MyWidget1``` and ```MyWidget2``` can be placed in a column, row etc..

- They are too much

  Almost all other packages are trying to be more than just a routing package. ```TabRouterController```, ```BottomRouteCntroller```, guards, etc... Wouter is not trying to be anything else then Routing package, keep it simple. No guards no controllers only one simple thing: path. The current path controls all what other widgets display or do.
  Using ```Redirect``` widget you can easily redirect unknown paths, Using the regex ```"/:_(.*)"```, and you can mount/unmount each route depending on if the user allowed there or not.
  ```dart
  MyWidget(
    child: SomeProvider(
        child: WouterSwitch(
        routes: {
          if (!isUserAuth)
            "/auth": (context, arguments) => const MaterialPage(
              child: MyAuthWidget(),
            ),
          if (isUserAuth)
            "/home": (context, arguments) => const MaterialPage(
              child: MyHomeWidget(),
            ),
          "/:_(.*)": (context, arguments) => MaterialPage(
            child: Redirect(
              to: isUserAuth ? "/home" : "/auth",
            ),
          ),
        }
      )
    )
  )
  ```
  All the magic happens when you use reactive getter (Stream, Provider, BLoC, Hooks etc..) for ```isUserAuth```, because each update will trigger a rebuild, so our routes will be rebuilt as well and will change depending on ```isUserAuth```. Without the need for more boilerplate, guards etc... again adding code which needs to be maintained for the user and the package maintainer.

## Features
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
- Matching routes out of build time (before running ```Widget build(BuildContext context)```)
- Immutability under the hood

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
    child: MyOtherWidget(
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

Wouter is base on single source of truth. There is only one [```Router```](https://api.flutter.dev/flutter/widgets/Router-class.html) at the base of the app (using [```WidgetsApp.router```](https://api.flutter.dev/flutter/widgets/WidgetsApp/WidgetsApp.router.html) and [```RouterDelegate```](https://api.flutter.dev/flutter/widgets/RouterDelegate-class.html)).

All children Wouters listen to changes on their parent and reacting to changes of the current route, when there is no change no work is being done.

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
