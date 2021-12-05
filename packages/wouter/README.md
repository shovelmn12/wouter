# wouter

### BETA Release - Docs WIP

Supercharge your routering with wouter, simple yet advanced and fully customizable routing package.

Features:
- Navigator 1.0 like API
- No boilerplate, no need to build a special class for locations
- Regexp support using [path_to_regexp](https://pub.dev/packages/path_to_regexp)
- Relative paths (```push(../../here)```, ```replace(../there)```) using normalize from [path](https://pub.dev/packages/path)
- Following everything is a widget, Wouter is a widget and its child is a Widget
- Nested and Parallel (multiple Wouters in a Column or a Row) Wouters
- Base paths
- Flexible navigators (Switch, Row, Column etc...) and easily build your own navigator

simple example:

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
                to: "/"
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
